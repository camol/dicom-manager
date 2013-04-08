# == Schema Information
#
# Table name: catalogs
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)
#  description      :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  ancestry         :string(255)
#  has_files        :boolean(1)      default(FALSE)
#  catalogable_id   :integer(4)
#  catalogable_type :string(255)
#  creator_id       :integer(4)
#  updater_id       :integer(4)
#

class Catalog < ActiveRecord::Base
  # Asign nested structure
  has_ancestry

  attr_accessible :description, :name

  # Relationships
  has_many :dicom_files, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true
  belongs_to :catalogable, polymorphic: true

  #validations
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }

  public
  def root?
    self.ancestry.nil?
  end

  def created_by?(user)
    self.id == user.id
  end
end

