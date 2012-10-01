class AddRefDicomFileToCatalog < ActiveRecord::Migration
  def change
    add_column :dicom_files, :catalog_id, :integer
  end
end
