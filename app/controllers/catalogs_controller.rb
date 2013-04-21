class CatalogsController < ApplicationController

  before_filter :check_permission, only: [:create]

  def show
    @new_catalog = Catalog.new
    @catalogs = current_catalog.kids
    @dicoms = current_catalog.dicom_files
  end

  def index
    # TO DO
    # Probably no need for it
    @new_catalog = Catalog.new
    @catalogs = current_user.catalogs.roots
  end

  def create
    if params[:catalog][:curr_cat_id].nil?
      redirect_to root_path
      #catalog = current_user.catalogs.build(params[:catalog])
    else
      catalog = Catalog.find(params[:catalog][:curr_cat_id]).children.create
      catalog.catalogable = Catalog.find(params[:catalog][:curr_cat_id]).catalogable
      catalog.name = params[:catalog][:name]
      catalog.description = params[:catalog][:description]
    end

    if catalog.save
      flash[:success] = "Catalog created"
        redirect_to catalog
    else
      flash[:failure] = "Failed to create catalog"
      redirect_to current_catalog
    end
  end

  def update
    @catalog = Catalog.find(params[:id])
    if @catalog.update_attributes(params[:catalog].except(:curr_cat_id))
      flash[:success] = "Catalog updated"
    else
      flash[:failure] = "Could not update catalog"
    end
    redirect_to @catalog
  end

  def move
    target_catalog = Catalog.find(params[:catalog][:target_catalog])
    moved_catalog = Catalog.find(params[:catalog][:moved_catalog])

    if moved_catalog.move_to(target_catalog)
      flash[:success] = "Moved catalog"
    else
      flash[:error] = "Error moving catalog"
    end

    redirect_to current_catalog
  end

  def destroy
    catalog = Catalog.find(params[:id])
    parent_catalog = catalog.parent
    if catalog.destroy
      flash[:success] = "Catalog deleted"
      redirect_to parent_catalog
    else
      flash[:failure] = "Could not delete current catalog"
    end
  end
end
