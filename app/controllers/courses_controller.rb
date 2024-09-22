class CoursesController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show
    @current = 0
  end

  def create
    if @course.save
      flash[:notice] = 'Course created successfully'
      redirect_to courses_mycourses_path(current_user)
    else
      flash[:alert] = 'Course not created'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @course.update(course_params)
      flash[:notice] = 'Course updated successfully'
      redirect_to courses_mycourses_path(current_user)
    else
      flash[:alert] = 'Course not updated'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    flash[:notice] = 'Course deleted successfully'
    redirect_to courses_mycourses_path(current_user)
  end

  protected

  def course_params
    params.require(:course).permit(:title, :description, :author_id)
  end
end
