class UserCoursesController < ApplicationController
  def mycourses
    @courses = Course.where(author_id: current_user.id)
  end

  def explore
    @courses = Course.where.not(author_id: current_user.id)
  end
end
