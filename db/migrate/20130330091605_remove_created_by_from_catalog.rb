class RemoveCreatedByFromCatalog < ActiveRecord::Migration
  def change
    remove_column :catalogs, :created_by
  end
end
