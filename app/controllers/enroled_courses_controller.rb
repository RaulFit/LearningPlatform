class EnroledCoursesController < ApplicationController
  def index
    @courses = Course.where(id: Enrolment.where(user_id: current_user.id).pluck(:course_id))
  end
end
