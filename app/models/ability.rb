class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can :create, Project if user.is_project_manager?
      can :create, Group if user.is_group_manager?
    end

    can :manage, Project, creator_id: user.id
    can :manage, Group, creator_id: user.id
    can :manage, Catalog, creator_id: user.id
  end
end
