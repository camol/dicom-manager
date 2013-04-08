# == Schema Information
#
# Table name: groups
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  creator_id  :integer(4)
#  updater_id  :integer(4)
#

class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  has_many :catalogs, as: :catalogable
  has_one :root_catalog, class_name: "Catalog", as: :catalogable, conditions: { ancestry: nil }
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true

  attr_accessible :name, :description
  attr_accessor :assign_current_user

  after_create :create_root_catalog

  def created_by?(user)
    self.creator_id == user.id
  end

  def create_root_catalog
    catalogs.create(name: name, description: "Root catalog for group")
  end
end


