class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, Course, author: user
    can :manage, Lesson
    can :manage, CourseLesson
    can :read, Course
    can :manage, Enrolment
  end
end
