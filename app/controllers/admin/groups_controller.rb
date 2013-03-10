class Admin::GroupsController < ApplicationController

  before_filter :find_group, except: [:index, :create, :new]

  def index
    @search = Group.search params[:q]
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
    group = Group.new params[:group]

    if group.save
      flash[:success] = "Group created"
    else
      flash[:failure] = "Failed to create group"
    end
    redirect_to admin_groups_path
  end

  def update
    if @group.update_attributes params[:group]
      flash[:notice] = "Group updated"
      redirect_to admin_group_path(@group)
    else
      flash[:error] = "Error updating group"
      render :edit
    end
  end

  def find_group
    @group = Group.find params[:id]
  end
end

