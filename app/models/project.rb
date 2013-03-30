class Project < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :catalogs, as: :catalogable
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true

  attr_accessible :name, :description, :group_ids

  def created_by?(user)
    self.id == user.id
  end
end



