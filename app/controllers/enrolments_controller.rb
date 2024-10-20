class EnrolmentsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :enrolment, through: :course

  def new; end

  def create
    return unless @enrolment.save

    flash[:notice] = "#{t(:enrolment_notice)} #{@course.title}"
    redirect_to courses_path(enroled: true)
  end

  def update
    @position = params[:position].to_i
    @enrolment.update_progress(@position)

    redirect_to courses_path(enroled: true) and return if @enrolment.progress == @course.course_lessons.size

    redirect_to course_lesson_path(@course, @course.course_lessons.find_by(position: @position).lesson)
  end

  def destroy
    @enrolment.destroy
  end

  def enrolment_params
    params.require(:enrolment).permit(:user_id, :course_id, :progress)
  end
end
