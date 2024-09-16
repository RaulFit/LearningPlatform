class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Course, author: user
    can :read, Course
    can :manage, Comment, user:
    # can :manage, Registration, user:
  end
end
