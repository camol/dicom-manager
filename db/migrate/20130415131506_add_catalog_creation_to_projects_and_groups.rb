class AddCatalogCreationToProjectsAndGroups < ActiveRecord::Migration
  def change
    add_column :projects, :catalog_creation, :boolean, default: false
    add_column :groups, :catalog_creation, :boolean, default: false
  end
end
