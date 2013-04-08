class Admin::GroupsController < ApplicationController
  def index
    @search = Group.search params[:q]
    @groups = @search.result.page params[:page]
  end
end

