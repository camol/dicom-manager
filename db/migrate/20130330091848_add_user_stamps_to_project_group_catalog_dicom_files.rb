class AddUserStampsToProjectGroupCatalogDicomFiles < ActiveRecord::Migration
  def change
    change_table :catalogs do |c|
      c.userstamps
    end
    change_table :projects do |c|
      c.userstamps
    end
    change_table :dicom_files do |c|
      c.userstamps
    end
    change_table :groups do |c|
      c.userstamps
    end
  end
end
