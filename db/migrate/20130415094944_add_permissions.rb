class AddPermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.string :action
      t.string :permissionable_type
      t.integer :permissionable_id
      t.timestamps
    end
  end
end
