class PermissionsController < ApplicationController
  def create
    permission = Permission.new(params[:permission])
    if permission.save
      flash[:success] = "Permission add."
    else
      flash[:error] = "Error on adding permission."
    end
    redirect_to request.referer
  end

  def destroy
    permission = Permission.find(params[:id])

    if permission.destroy
      flash[:success] = "Permission forbided."
    else
      flash[:error] = "Error on forbiding the permission."
    end
    redirect_to request.referer
  end
end

