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
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true

  include Rails.application.routes.url_helpers

  validates_attachment :dicom, presence: true, content_type: { content_type: "application/dicom" }

  def name
    self.dicom_file_name.chomp('.dcm')
  end

  def to_jq_upload
    {
      "name" => read_attribute(:dicom_file_name),
      "size" => read_attribute(:dicom_file_size),
    }
  end

  def created_by?(user)
    self.id == user.id
  end
end

