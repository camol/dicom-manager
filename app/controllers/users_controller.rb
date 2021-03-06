class UsersController < ApplicationController
 before_filter :correct_user , only: [:show, :edit, :update, :edit_share, :update_share]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def edit_share
    @user = User.find(params[:id])
  end

  def update_share
    if @user.update_attributes(params[:user])
      flash[:success] = "Sharing updated."
    else
      flash[:error] = "Failed to update user sharing."
    end
    redirect_to @user
  end

  private
  def correct_user
    @user = User.find(params[:id])
    if current_user.admin?
      redirect_to root_path unless current_user?(@user)
    end
  end

end
