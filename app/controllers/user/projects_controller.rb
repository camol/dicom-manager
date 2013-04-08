class User::ProjectsController < ApplicationController
  def index
    @search = Project.search params[:q]
    @projects = current_user.created_projects
  end
end


