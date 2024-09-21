class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, Course, author: user
    can :manage, Lesson, course: { author_id: user.id }
    can :read, Course
    can :manage, Lesson
    can %i[create destroy], Registration do |reg|
      reg.course.author_id != user.id
    end
  end
end
