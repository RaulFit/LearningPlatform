class EnrolmentsController < ApplicationController
  load_and_authorize_resource

  def new
    @course = Course.find(params[:course_id])
  end

  def create
    @course = Course.find(enrolment_params[:course_id])
    return unless @enrolment.save

    flash[:notice] = "#{t(:enrolment_notice)} #{@course.title}"
    redirect_to courses_path(enroled: true)
  end

  def destroy
    @enrolment.destroy
  end

  def enrolment_params
    params.require(:enrolment).permit(:user_id, :course_id)
  end
end
