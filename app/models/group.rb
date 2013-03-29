class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  has_many :catalogs, as: :catalogable

  attr_accessible :name, :description
end


