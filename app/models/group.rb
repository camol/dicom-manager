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
  include CatalogExtension

  attr_accessible :groups_projects_attributes
  has_many :groups_users, dependent: :destroy
  has_many :users, through: :groups_users
  has_many :groups_projects, dependent: :destroy
  has_many :projects, through: :groups_projects
  has_many :catalogs, as: :catalogable
  has_one :root_catalog, class_name: "Catalog", as: :catalogable, conditions: { ancestry: nil }
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true

  accepts_nested_attributes_for :groups_projects

  attr_accessible :name, :description, :catalog_creation
  attr_accessor :assign_current_user

  after_create :create_root_catalog

  def created_by?(user)
    self.creator_id == user.id
  end

  def shares_with_project?(project)
    groups_projects.where(project_id: project).first.share
  end

  def create_root_catalog
    catalog_description = "Root catalog for #{name} (#{self.class.to_s})"
    catalogs.create(name: name.downcase, description: catalog_description)
  end
end


