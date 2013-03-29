class Project < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :catalogs, as: :catalogable

  attr_accessible :name, :description, :group_ids
end



