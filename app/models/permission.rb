class Permission < ActiveRecord::Base
  attr_accessible :permissionable_id, :permissionable_type, :user_id, :action
  belongs_to :user
  belongs_to :permissionable, polymorphic: true

  def self.find_by_user_and_resource(user, resource)
    where(user_id: user.id, permissionable_type: resource.class.to_s, permissionable_id: resource.id).limit(1).first
  end
end
