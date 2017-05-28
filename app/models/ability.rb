class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new

        if user.superadmin?
            can :manage, :all
            cannot :edit, [User]
        elsif user.admin?
            can :manage, :all
            cannot :manage, [SuperAdmin, Admin, Team]
            cannot :edit, [User]
            can :read, [Team]
        else 
            can :manage, [Team]
        end
    end
end
