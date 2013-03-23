class Project < ActiveRecord::Base
  has_and_belongs_to_many :groups

  attr_accessible :name, :description, :group_ids
end



