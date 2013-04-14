class AddIdAndShareColumnToGroupsUsers < ActiveRecord::Migration
  def change
    add_column :groups_users, :id, :primary_key
    add_column :groups_users, :share, :boolean, default: false
  end
end
