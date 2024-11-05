class LessonsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :enrolment, through: :course
  load_and_authorize_resource :lesson, through: :course

  def index; end

  def show
    @course_lesson = @course.course_lessons.find_by(lesson_id: @lesson.id)
  end

  def new; end

  def create
    if @lesson.save
      @course.course_lessons.create(course_id: @course.id, lesson_id: @lesson.id,
                                    position: @course.course_lessons.count)
      flash[:notice] = t(:lesson_notice)
      redirect_to course_lessons_path(@course)
    else
      flash[:alert] = t(:lesson_alert)
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @lesson.update(lesson_params)
      flash[:notice] = t(:lesson_update_notice)
      redirect_to course_lessons_path(@course)
    else
      flash[:alert] = t(:lesson_update_alert)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy
    flash[:notice] = t(:lesson_destroy_notice)
    redirect_to courses_path(authored: true)
  end

  protected

  def lesson_params
    params.require(:lesson).permit(:title, :photo, :content, :course_id)
  end
end
