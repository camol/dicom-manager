class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionHelper
  include CatalogsHelper

    private

  # Overwriting the sign_out redirect path method and change https -> http
	def after_sign_out_path_for(resource_or_scope)
	  root_url :protocol => 'http'
	end
end
