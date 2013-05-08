module ApplicationHelper
	def full_title(page_title)
		base_title = "Dicom Manager"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"	
		end
	end

	def body_class
		@body_class || ''
	end

  def current_resource_name
    params[:controller].split('/').last
  end

  def current_namespace
    params[:controller].split('/').first
  end

  def display_title(object)
    object.created_by?(current_user) ? "#{object.name} (Owned)" : object.name
  end
end
