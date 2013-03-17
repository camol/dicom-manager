class UsersController < ApplicationController
 before_filter :correct_user , only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  private
  def correct_user
    @user = User.find(params[:id])
    if current_user.admin?
      redirect_to root_path unless current_user?(@user)
    end
  end

end
