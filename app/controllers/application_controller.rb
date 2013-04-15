class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :is_user_enabled?
  include Userstamp
  include SessionHelper
  include CatalogsHelper
  include UsersHelper

    private

  # Overwriting the sign_out redirect path method and change https -> http
	def after_sign_out_path_for(resource_or_scope)
	  root_url :protocol => 'http'
	end

  def is_user_enabled?
    if !current_user.nil? && !current_user.enabled?
      reset_session
      render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false, :format => :html
    end
  end
end
