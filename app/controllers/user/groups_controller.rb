class User::GroupsController < ApplicationController
  def index
    @search = current_user.created_groups.search params[:q]
    @groups = @search.result.page params[:page]
  end
end

