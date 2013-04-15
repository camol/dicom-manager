module CatalogsHelper
  def current_catalog
    if params.has_key?(:id)
      @current_catalog ||= Catalog.find(params[:id])
    elsif !params[:catalog].nil? and !params[:catalog][:curr_cat_id].nil?
      @current_catalog ||= Catalog.find(params[:catalog][:curr_cat_id])
    elsif params.has_key?(:catalog_id)
      @current_catalog ||= Catalog.find(params[:catalog_id])
    end
  end

  def path_to(catalog)
    path =""
    if !catalog.is_root?
      catalog.ancestors.all.each do |cat|
        path += "/#{cat.name}"
      end
    end
    path += "/#{catalog.name}"   
  end

  def catalog_form_for(catalog)
    simple_form_for catalog do |f|
      render 'catalogs/catalog_form', f: f
    end
  end
end
