class CatalogsController < ApplicationController

  def show
    @new_catalog = Catalog.new
    @catalogs = current_catalog.children
  end

  def index
    @new_catalog = Catalog.new
    @catalogs = current_user.catalogs.roots
  end
  
  def new
  end

  def create
    if params[:catalog][:curr_cat_id].nil?
      catalog = current_user.catalogs.build(params[:catalog])
    else
      catalog = current_user.catalogs.find(params[:catalog][:curr_cat_id]).children.create
      catalog.user_id = current_user.id
      catalog.name = params[:catalog][:name]
      catalog.description = params[:catalog][:description]
    end

    if catalog.save
      flash[:success] = "Catalog created"
      if catalog.is_root?
        redirect_to catalogs_path
      else
        redirect_to catalog.parent 
      end
    else
      flash[:failure] = "Failed to create catalog"
      redirect_to catalogs_path
    end
  end
end
