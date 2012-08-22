class Ability
    include CanCan::Ability

    def initialize(user)
        user ||= User.new

        if user.superadmin?
            can :manage, :all
            cannot :manage, [Handler, Dog]
            cannot :edit, [User]
            can :read, [Handler, Dog]
        elsif user.admin?
            can :manage, :all
            cannot :manage, [SuperAdmin, Admin, Handler, Dog]
            cannot :edit, [User]
            can :read, [Handler, Dog]
        else 
            can :manage, [Handler, Dog]
        end
    end
end
