class AddShareColumnToGroupsProjects < ActiveRecord::Migration
  def change
    add_column :groups_projects, :share, :boolean, default: false
  end
end
