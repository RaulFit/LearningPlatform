class LessonsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :lesson, through: :course

  def index; end

  def show; end

  def new; end

  def create
    if @lesson.save
      flash[:notice] = 'Lesson created successfully'
      redirect_to courses_mycourses_path(current_user)
    else
      flash[:alert] = 'Lesson not created'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @lesson.update(lesson_params)
  end

  def destroy
    @lesson.destroy
  end

  protected

  def lesson_params
    params.require(:lesson).permit(:title, :body, :course_id)
  end
end
