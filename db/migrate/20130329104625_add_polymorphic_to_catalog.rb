class AddPolymorphicToCatalog < ActiveRecord::Migration
  def change
    add_column :catalogs, :catalogable_id, :integer
    add_column :catalogs, :catalogable_type, :string
  end
end
