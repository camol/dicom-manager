class Admin::ProjectsController < ApplicationController
  def index
    @search = Project.search params[:q]
    @projects = @search.result.page params[:page]
  end
end


