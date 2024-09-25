class AvailableCoursesController < ApplicationController
  def index
    @courses = Course.where.not(author_id: current_user.id)
                     .where.not(id: Enrolment.where(user_id: current_user.id)
                     .pluck(:course_id))
  end
end
