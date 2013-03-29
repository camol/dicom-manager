class RemoveUserIdFromCatalogs < ActiveRecord::Migration
  def up
    Catalog.all.each do |c|
      c.update_attribute(:created_by, c.user_id)
      c.update_attribute(:catalogable_id, c.user_id)
      c.update_attribute(:catalogable_type, 'User')
    end
    remove_column :catalogs, :user_id
  end

  def down
    add_column :catalogs, :user_id, :integer
  end
end
