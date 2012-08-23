class Catalog < ActiveRecord::Base
  # Asign nested structure
  has_ancestry

  attr_accessible :description, :name

  # Relationships
  belongs_to :user

  #validations
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }
end
