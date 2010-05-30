class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    elsif user.not_guest?
      can :create, [Issue, Wish]
      can [:update, :destroy], [Issue, Wish], :user => user
      can :add_vote, Wish
    end
    can :read, [Wish, Issue]
  end
end
