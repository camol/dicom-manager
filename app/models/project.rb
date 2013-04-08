# == Schema Information
#
# Table name: projects
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  creator_id  :integer(4)
#  updater_id  :integer(4)
#

class Project < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :catalogs, as: :catalogable
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true
  has_one :root_catalog, class_name: "Catalog", as: :catalogable, conditions: { ancestry: nil }

  attr_accessible :name, :description, :group_ids

  after_create :create_root_catalog

  def created_by?(user)
    self.id == user.id
  end


  private

  def create_root_catalog
    catalogs.create(name: name, description: "Root catalog for project")
  end
end

