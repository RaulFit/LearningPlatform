class EnrolmentsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :enrolment, through: :course

  def new; end

  def create
    return unless @enrolment.save

    flash[:notice] = "Successfully enroled to #{@course.title}"
    redirect_to user_enroled_courses_path(current_user)
  end

  def destroy
    @enrolment.destroy
  end

  def enrolment_params
    params.require(:enrolment).permit(:user_id, :course_id)
  end
end
