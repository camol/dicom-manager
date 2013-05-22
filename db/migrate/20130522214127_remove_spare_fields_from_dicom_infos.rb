class RemoveSpareFieldsFromDicomInfos < ActiveRecord::Migration
  def change
    change_table :dicom_infos do |t|
      t.remove :content_date
      t.remove :content_time
      t.remove :station_name
    end
  end
end
