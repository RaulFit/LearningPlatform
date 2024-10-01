class CoursesController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:available]
      @courses = @courses.available(current_user.id).map do |course|
        { course:, available: true }
      end
    elsif params[:enroled]
      @courses = @courses.enroled(current_user.id).map do |course|
        { course:, enroled: true }
      end
    elsif params[:authored]
      @courses = current_user.authored_courses.map { |course| { course:, authored: true } }
    end
  end

  def show
    @lesson = @course.lessons.first
  end

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
    params.require(:course).permit(:title, :description, :author_id)
  end
end
