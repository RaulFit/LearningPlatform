class UserCoursesController < ApplicationController
  def mycourses
    @courses = Course.where(author_id: current_user.id)
  end

  def explore
    @courses = Course.where.not(author_id: current_user.id)
                     .where.not(id: Registration.where(user_id: current_user.id)
                     .pluck(:course_id))
  end

  def registrations
    @courses = Course.where(id: Registration.where(user_id: current_user.id).pluck(:course_id))
  end
end
