class AddDicomThumbToDicomFiles < ActiveRecord::Migration
  def change
    add_attachment :dicom_files, :dicom_thumb
  end
end
