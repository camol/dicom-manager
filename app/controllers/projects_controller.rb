class ProjectsController < ApplicationController
  before_filter :find_project, except: [:index, :create, :new]

  def index
    @search = current_user.projects.search params[:q]
    @projects = @search.result.page params[:page]
  end

  def show
  end

  def edit
  end

  def new
    @project = Project.new
  end

  def create
    project = Project.new params[:project]

    if project.save
      flash[:success] = "Project created"
    else
      flash[:failure] = "Failed to create project"
    end
    redirect_to project_path(project)
  end

  def update
    if @project.update_attributes params[:project]
      flash[:success] = "Project updated"
      redirect_to project_path(@project)
    else
      flash[:error] = "Error updating project"
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = "Project destroyed"
    else
      flash[:error] = "Could not destroy the project"
    end
    redirect_to project_path(@project)
  end

  private
  def find_project
    @project = Project.find params[:id]
  end
end


