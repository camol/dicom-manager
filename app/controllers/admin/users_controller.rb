class Admin::UsersController < ApplicationController
  before_filter :find_user, except: [:index]
  before_filter :prepare_roles, only: [:create, :update]

  def index
    @search = User.search params[:q]
    @users = @search.result.page params[:page]
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes params[:user]
      flash[:notice] = "User updated"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "Error updating user"
      render :edit
    end
  end

  private
  def find_user
    @user = User.find params[:id]
  end

  def prepare_roles
    params[:user][:roles] -= [""]
  end
end
