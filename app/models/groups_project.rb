class GroupsProject < ActiveRecord::Base
  attr_accessible :share
  belongs_to :project
  belongs_to :group
end
