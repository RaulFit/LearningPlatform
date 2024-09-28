class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, Course, author: user
    can :manage, Lesson, course: { author_id: user.id }
    can :read, Course
    can %i[create destroy], Enrolment
  end
end
