class AddAncestryToCatalog < ActiveRecord::Migration
  def change
    add_column :catalogs, :ancestry, :string
    add_index :catalogs, :ancestry
  end
end
