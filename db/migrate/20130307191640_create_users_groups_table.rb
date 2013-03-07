class CreateUsersGroupsTable < ActiveRecord::Migration
  def change
    create_table :groups_users, id: false do |t|
      t.integer :group_id
      t.integer :user_id
      t.timestamps
    end
  end
end
