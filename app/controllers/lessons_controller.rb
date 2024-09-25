class LessonsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :lesson, through: :course

  def index; end

  def show; end

  def new; end

  def create
    if @lesson.save
      flash[:notice] = 'Lesson created successfully'
      redirect_to user_authored_courses_path(current_user)
    else
      flash[:alert] = 'Lesson not created'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @lesson.update(lesson_params)
      flash[:notice] = 'Lesson updated successfully'
      redirect_to user_authored_courses_path(current_user)
    else
      flash[:alert] = 'Lesson not updated'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy
    flash[:notice] = 'Lesson deleted successfully'
    redirect_to user_authored_courses_path(current_user)
  end

  protected

  def lesson_params
    params.require(:lesson).permit(:title, :content, :course_id)
  end
end
