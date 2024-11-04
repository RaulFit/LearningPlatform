class CoursesController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :course_lesson, through: :course
  load_and_authorize_resource :lesson, through: :course_lesson

  def index
    @courses = @courses.where(['title LIKE ?', "%#{params[:search]}%"]) if params[:search].present?

    if params[:available]
      @courses = @courses.available(current_user.id)
    elsif params[:enroled]
      @courses = @courses.enroled(current_user.id)
    elsif params[:authored]
      @courses = @courses.authored(current_user.id)
    end
  end

  def show; end

  def create
    if @course.save
      flash[:notice] = t(:course_notice)
      redirect_to courses_path(authored: true)
    else
      flash[:alert] = t(:course_alert)
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @course.update(course_params)
      flash[:notice] = t(:course_update_notice)
      redirect_to courses_path(authored: true)
    else
      flash[:alert] = t(:course_alert_notice)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    flash[:notice] = t(:course_destroy_notice)
    redirect_to courses_path(authored: true)
  end

  protected

  def course_params
    params.require(:course).permit(:title, :photo, :description, :difficulty, :public, :author_id)
  end
end
