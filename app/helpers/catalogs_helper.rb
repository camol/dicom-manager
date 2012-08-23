module CatalogsHelper
  def current_catalog
    if !params[:id].nil?
      @current_catalog ||= Catalog.find(params[:id]) 
    elsif !params[:catalog][:curr_cat_id].nil?
      @current_catalog ||= Catalog.find(params[:catalog][:curr_cat_id]) 
    end
  end
end
