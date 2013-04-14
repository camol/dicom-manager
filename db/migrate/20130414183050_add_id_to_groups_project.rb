class AddIdToGroupsProject < ActiveRecord::Migration
  def change
    add_column :groups_projects, :id, :primary_key
  end
end
