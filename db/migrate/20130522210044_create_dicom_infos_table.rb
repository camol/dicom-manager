class  CreateDicomInfosTable < ActiveRecord::Migration
  def change
    create_table :dicom_infos do |t|
      t.integer :dicom_file_id
      t.string :instance_creation_date
      t.string :instance_creation_time
      t.string :study_date
      t.string :content_date
      t.string :study_time
      t.string :content_time
      t.string :institution_name
      t.string :referring_physician_name
      t.string :station_name
      t.string :patients_name
      t.string :patient_id
      t.string :patient_birth_date
      t.string :patient_sex
      t.string :image_comments
      t.string :sop_instance_uid
    end
  end
end
