class CoursesController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def create
    @article.create
  end

  def edit; end

  def update
    @article.update(course_params)
  end

  def destroy
    @article.destroy
  end

  protected

  def course_params
    params.require(:course).permit(:title, :description, :author_id)
  end
end
