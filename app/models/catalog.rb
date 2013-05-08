# == Schema Information
#
# Table name: catalogs
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)
#  description      :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  ancestry         :string(255)
#  has_files        :boolean(1)      default(FALSE)
#  catalogable_id   :integer(4)
#  catalogable_type :string(255)
#  creator_id       :integer(4)
#  updater_id       :integer(4)
#

class Catalog < ActiveRecord::Base
  # Asign nested structure
  has_ancestry

  attr_accessible :description, :name, :creator_id, :updater_id, :catalogable
  attr_accessor :target_catalog

  # Relationships
  has_many :dicom_files, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'creator_id', validate: true
  belongs_to :catalogable, polymorphic: true

  #validations
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }

  def kids
    assigned_children = []
    if self.root?
      case self.catalogable_type
      when "Project"
        assigned_children = catalogable.groups.map{|g| g.root_catalog if g.shares_with_project?(catalogable) }.compact
      when "Group"
        assigned_children = catalogable.users.map{|u| u.root_catalog if u.shares_with_group?(catalogable) }.compact
      end
    end
    self.children + assigned_children
  end

  def grandparent
    self.parent.nil? ? nil : self.parent.parent
  end

  def root?
    self.ancestry.nil?
  end

  def created_by?(user)
    self.id == user.id
  end

  def move_to(target)
    unless self.catalogable == target.catalogable
      self.children.update_all(catalogable_id: target.catalogable_id, catalogable_type: target.catalogable_type)
    end

    self.parent = target
    self.save
  end
end

