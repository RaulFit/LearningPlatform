class AuthoredCoursesController < ApplicationController
  def index
    @courses = Course.where(author_id: current_user.id)
  end
end
