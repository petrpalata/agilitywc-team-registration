class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new

        if user.superadmin?
            can :manage, :all
            cannot :edit, [User]
        elsif user.admin?
            can :manage, :all
            cannot :manage, [SuperAdmin, Admin, Team, Dog]
            cannot :edit, [User]
            can :read, [Team, Dog]
        else 
            can :manage, [Team, Dog]
        end
    end
end
