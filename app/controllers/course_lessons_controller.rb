class CourseLessonsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :course_lesson, through: :course

  def update
    ActiveRecord::Base.transaction do
      @first_lesson = @course.course_lessons.find_by(position: course_lesson_params[:position].to_i)
      if course_lesson_params[:up] && course_lesson_params[:position].to_i.positive?
        @second_lesson = @course.course_lessons.find_by(position: course_lesson_params[:position].to_i - 1)
      elsif course_lesson_params[:down] && course_lesson_params[:position].to_i < @course.course_lessons.count - 1
        @second_lesson = @course.course_lessons.find_by(position: course_lesson_params[:position].to_i + 1)
      end
      @course.swap_lessons(@first_lesson, @second_lesson)
    end

    redirect_to course_lessons_path(@course)
  end

  def destroy
    @course_lesson.destroy
    flash[:notice] = t(:lesson_destroy_notice)
    redirect_to course_lessons_path(@course)
  end

  private

  def course_lesson_params
    params.permit(:up, :down, :position)
  end
end
