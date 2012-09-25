class AddHasFilesToCatalog < ActiveRecord::Migration
  def change
    add_column :catalogs, :has_files, :boolean, default: false
  end
end
