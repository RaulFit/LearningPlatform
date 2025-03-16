class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, User
    return unless user.present?

    can :manage, User
    can :manage, Course, author: user
    can :manage, Lesson
    can :manage, Comment
    can :manage, CourseLesson
    can :read, Course
    can :manage, Enrolment
  end
end
