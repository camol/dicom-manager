module UsersHelper
  def resource
    @resource = current_user
  end

  def resource_name
    :user
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def can_manage?(resource)
    current_user.admin? || resource.created_by?(current_user)
  end

  def check_permission
    has_permission = true
    unless current_user.admin?
      if current_catalog.catalogable_type == "User"
        unless current_catalog == current_user.root_catalog
          has_permission = false
        end
      else
        has_permission = current_user.has_permission?('create', current_catalog.catalogable)
      end
    end
    has_permission
  end
end
