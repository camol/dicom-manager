# == Schema Information
#
# Table name: catalogs
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  user_id     :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  ancestry    :string(255)
#  has_files   :boolean(1)      default(FALSE)
#

class Catalog < ActiveRecord::Base
  # Asign nested structure
  has_ancestry

  attr_accessible :description, :name

  # Relationships
  has_many :dicom_files, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'created_by', validate: true
  belongs_to :catalogable, polymorphic: true

  #validations
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }

  public
  def root?
    self.ancestry.nil?
  end

end

