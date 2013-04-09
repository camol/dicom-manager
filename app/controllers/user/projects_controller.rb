class User::ProjectsController < ApplicationController
  def index
    @search = current_user.created_projects.search params[:q]
    @projects = @search.result.page params[:page]
  end
end


