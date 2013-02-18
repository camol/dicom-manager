# == Schema Information
#
# Table name: dicom_files
#
#  id                 :integer(4)      not null, primary key
#  dicom_file_name    :string(255)
#  dicom_content_type :string(255)
#  dicom_file_size    :integer(4)
#  dicom_updated_at   :datetime
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  catalog_id         :integer(4)
#

class DicomFile < ActiveRecord::Base
  attr_accessible :dicom
  has_attached_file :dicom

  belongs_to :catalog
end

