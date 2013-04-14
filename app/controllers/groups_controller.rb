class GroupsController < ApplicationController

  before_filter :find_group, except: [:index, :create, :new]
  before_filter :assign_user, only: [:create, :update]

  def index
    @search = current_user.groups.search params[:q]
    @groups = @search.result.page params[:page]
  end

  def show
  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
    group = @assign_current_user ? current_user.groups.build(params[:group]) : Group.new(params[:group])

    if current_user.save && group.save
      flash[:success] = "Group created"
    else
      flash[:failure] = "Failed to create group"
    end
    redirect_to group_path(group)
  end

  def update
    @assign_current_user ? (current_user.groups << @group unless current_user.groups.include?(@group)) : current_user.groups.delete(@group)

    if current_user.save && @group.update_attributes(params[:group])
      flash[:notice] = "Group updated"
      redirect_to group_path(@group)
    else
      flash[:error] = "Error updating group"
      render :edit
    end
  end

  def find_group
    @group = Group.find params[:id]
  end

  def assign_user
    assign = params[:group].delete(:assign_current_user)
    @assign_current_user = assign == "1" ? true : false
  end
end

