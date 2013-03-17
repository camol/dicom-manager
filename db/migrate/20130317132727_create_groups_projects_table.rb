class CreateGroupsProjectsTable < ActiveRecord::Migration
  def change
    create_table :groups_projects, id: false do |t|
      t.integer :group_id
      t.integer :project_id
      t.timestamps
    end
  end
end
