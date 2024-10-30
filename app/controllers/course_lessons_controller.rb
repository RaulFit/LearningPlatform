class CourseLessonsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :course_lesson, through: :course

  def update
    ActiveRecord::Base.transaction do
      if params[:up] && params[:position].to_i.positive?
        @first_lesson = @course.course_lessons.find_by(position: params[:position].to_i)
        @second_lesson = @course.course_lessons.find_by(position: params[:position].to_i - 1)
        @course.swap_lessons(@first_lesson, @second_lesson)
      elsif params[:down] && params[:position].to_i < @course.course_lessons.count - 1
        @first_lesson = @course.course_lessons.find_by(position: params[:position].to_i)
        @second_lesson = @course.course_lessons.find_by(position: params[:position].to_i + 1)
        @course.swap_lessons(@first_lesson, @second_lesson)
      end
    end

    redirect_to course_lessons_path(@course)
  end

  def destroy
    @course_lesson.destroy
    flash[:notice] = t(:lesson_destroy_notice)
    redirect_to course_lessons_path(@course)
  end
end
