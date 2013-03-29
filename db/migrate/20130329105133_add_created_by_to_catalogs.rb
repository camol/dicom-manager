class AddCreatedByToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :created_by, :integer
  end
end
