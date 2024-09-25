class EnrolmentsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :enrolment, through: :user

  def new; end

  def create
    return unless @enrolment.save

    flash[:notice] = "Successfully registered to #{@course.title}"
    redirect_to user_courses_mycourses_path(current_user)
  end

  def destroy
    @enrolment.destroy
  end

  def registration_params
    params.require(:enrolment).permit(:user_id, :course_id)
  end
end
