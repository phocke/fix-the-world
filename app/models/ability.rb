class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    elsif user.not_guest?
      can :create, Wish
      can :update, Wish, :user => user
      can :add_vote, Wish
    end
    can :read, Wish
  end
end
