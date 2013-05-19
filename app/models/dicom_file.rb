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
#  creator_id         :integer(4)
#  updater_id         :integer(4)
#
require 'dicom'
require 'rmagick'

class DicomFile < ActiveRecord::Base
  attr_accessible :dicom, :dicom_thumb
  has_attached_file :dicom
  has_attached_file :dicom_thumb, :styles => { :thumb => ["60x60#", :png] }
  include DICOM

  belongs_to :catalog
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true

  after_commit :anonymize, :unless => Proc.new{ self.dicom_content_type == "application/dicom" }
  after_commit :create_thumb, :unless => Proc.new{ self.dicom_content_type == "application/dicom" }

  include Rails.application.routes.url_helpers

  validates_attachment :dicom, presence: true
  validates_attachment :dicom_thumb, :content_type => { :content_type => "image/png" }

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
    self.creator_id == user.id
  end

  def dcm
    DObject.read(self.dicom.path)
  end

  def tags
    dcm.to_hash
  end

  def store_path
    self.dicom.path.match(/.*\//).to_s
  end

  def anonymize
    Anonymizer.new.anonymize(self.dicom.path)
  end

  def create_thumb
    image = self.dcm.image(level: [self.dcm.value("0028,1050").to_i, self.dcm.value("0028,1051").to_i])
    if image
      thumb_path = self.store_path + 'thumb.png'
      image.normalize.write(thumb_path)
      thumb = Magick::Image.read(thumb_path).first.resize(100, 100)
      thumb.write(thumb_path)
      self.dicom_thumb = File.new(thumb_path)
      self.save
    end
  end

  def anonymize_image

  end
end

