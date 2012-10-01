class CreateDicomFiles < ActiveRecord::Migration
  def change
    create_table :dicom_files do |t|
      t.attachment :dicom
      t.timestamps
    end
  end
end
