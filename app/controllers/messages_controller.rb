class MessagesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @messagebox = params[:messagebox].blank? ? "inbox" : params[:messagebox]
    @messages = current_user.send(@messagebox).group(:subject_id).page(params[:page]).per(10)

    case @messagebox
    when "trash"
      @options = ["Read","Unread","Delete","Undelete"]
    else
      @options = ["Read","Unread","Delete"]
    end
  end
	
	def show
    unless params[:messagebox].blank?
      message = current_user.send(params[:messagebox]).find(params[:id])

      @messages = message.root.subtree
      @parent_id = @messages.last.id

      if @messages.last.copies
        @user_tokens = @messages.last.recipient_id
        @parent_id = @messages.last.ancestor_ids.last unless @parent_id.nil?
      else
        @user_tokens = @messages.last.sender_id
      end

      read_unread_messages(true, *@messages)
    end
	end

  def admission_request
    @new_groups = Group.where('id NOT IN (?)', (current_user.groups + current_user.created_groups).uniq)
  end

  def send_admission_request
    if params[:admission_request][:project_id].present?
      recipient = Project.find(params[:admission_request][:project_id])
      group = Group.find(params[:admission_request][:group_id])
      request = "G:#{group.id}:#{recipient.id}"
      subject = "### #{group.name} (Group) join request for '#{recipient.name}' (Project) ###"
    elsif params[:admission_request][:group_id].present?
      recipient = Group.find(params[:admission_request][:group_id])
      request = "U:#{current_user.id}:#{recipient.id}"
      subject = "### #{current_user.full_name} (User) join request for '#{recipient.name}' (Group) ###"
    else
      flash[:error] = "Can not send empty request"
      redirect_to :back
    end

    if current_user.send_message?(recipients: [recipient.author], subject_id: nil, subject: subject, content: '', parent_id: nil, request: request )
      flash[:success] = "Successfully send join request."
    else
      flash[:error] = "Could not send the request."
    end
    redirect_to root_path
  end

  def act_admission_request
    req = Message.find(params[:id])
    req_params = req.request.split(':')

    case req_params[0]
    when "U"
      req_author = User.find(req_params[1])
      req_target = Group.find(req_params[2])
      resource = " "
    else
      req_author = Group.find(req_params[1])
      req_target = Project.find(req_params[2])
      resource = " '#{req_author.name}' (#{req_author.class.to_s}) "
    end

    if params[:decision] == 'accept'
      past_tense = "ed"

      case req_params[0]
      when "U"
        req_author.groups << req_target
      else
        past_tense = "d"
        req_author.projects << req_target
      end
    else
      past_tense = "d"
    end

    subject = "#{params[:decision].titleize + past_tense} your request for joining" + resource + "to '#{req_target.name}' (#{req_target.class.to_s})"
    p subject
    current_user.send_message?(recipients: [req.sender], subject_id: nil, subject: subject, content: subject, parent_id: nil)
    req.update_column(:opened, true)

    redirect_to messages_path(:inbox)
  end

	def new
	end

	def create
    unless params[:user_tokens].blank? or params[:subject].blank? or params[:content].blank?
      recipients = User.find(params[:user_tokens].split(",").collect { |id| id.to_i })
      if current_user.send_message?(:recipients => recipients, :subject_id => params[:subject_id], :subject => params[:subject], :content => params[:content], :parent_id => params[:parent_id])
        redirect_to box_messages_url(:inbox), :notice => 'Successfully send message.'
      else
        flash.now[:alert] = "Unable to send message."
        render "new"
      end
    else
      flash.now[:alert] = "Invalid input for sending message."
      render "new"
    end
	end

	def update
    unless params[:messages].nil?
      _message = current_user.send(params[:messagebox]).find(params[:messages])
      _message.each do |message|
        messages = message.root.subtree
        if params[:option].downcase == "read"
          read_unread_messages(true,*messages)
        elsif params[:option].downcase == "unread"
          read_unread_messages(false,*messages)
        elsif params[:option].downcase == "delete"
          delete_messages(true,*messages)
        elsif params[:option].downcase == "undelete"
          delete_messages(false,*messages)
        end
      end
    end
    redirect_to box_messages_url(params[:messagebox]) 
	end

	def empty
    unless params[:messagebox].nil?
      current_user.empty_messages(params[:messagebox].to_sym => true)
      redirect_to box_messages_url(params[:messagebox]), :notice => "Successfully delete all messages."
    end
	end

	def token
    query = "%" + params[:q] + "%"
    recipients = User.select("id,email").where("email like ?", query)
    respond_to do |format|
      format.json { render :json => recipients.map { |u| { "id" => u.id, "name" => u.email} } }
    end
	end

private

  def read_unread_messages(isRead, *messages)
    messages.each do |msg|
      unless msg.copies
        if isRead
          msg.mark_as_read unless msg.read?
        else
          msg.mark_as_unread if msg.read?
        end
      end
    end
  end

	def delete_messages(isDelete, *messages)
    messages.each do |msg|
      if isDelete
        msg.delete
      else
        msg.undelete
      end
    end
	end

end
