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
  include CatalogExtension

  has_many :groups_projects, dependent: :destroy
  has_many :groups, through: :groups_projects
  has_many :catalogs, as: :catalogable
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true
  has_many :permissions, as: :permissionable
  has_one :root_catalog, class_name: "Catalog", as: :catalogable, conditions: { ancestry: nil }

  attr_accessible :name, :description, :group_ids, :catalog_creation, :creator_id, :updater_id

  after_create :create_root_catalog

  def created_by?(user)
    self.creator_id == user.id
  end

  def create_root_catalog
    catalog_description = "Root catalog for #{name} (#{self.class.to_s})"
    catalogs.create(name: name.downcase, description: catalog_description)
  end
end

