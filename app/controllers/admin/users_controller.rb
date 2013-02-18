class Admin::UsersController < ApplicationController
  def index
    @search = User.search params[:q]
    @users = @search.result.page params[:page]
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.update_attributes params[:user]
      flash[:notice] = "User updated"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "Error updating user"
      render :edit
    end
  end
end
