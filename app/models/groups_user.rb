class GroupsUser < ActiveRecord::Base
  attr_accessible :share
  belongs_to :user
  belongs_to :group
end
