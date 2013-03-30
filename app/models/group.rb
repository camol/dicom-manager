class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  has_many :catalogs, as: :catalogable
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true

  attr_accessible :name, :description

  def created_by?(user)
    self.id == user.id
  end
end


