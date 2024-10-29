class CoursesController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :course_lesson, through: :course

  def index
    if params[:available]
      @available_courses = @courses.where(['title LIKE ?', "%#{params[:search]}%"]).where(public: true)
      @available = true
    elsif params[:enroled]
      @enroled_courses = @courses.enroled(current_user.id).where(['title LIKE ?', "%#{params[:search]}%"])
      @enroled = true
    elsif params[:authored]
      @authored_courses = current_user.authored_courses.where(['title LIKE ?', "%#{params[:search]}%"])
      @authored = true
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
