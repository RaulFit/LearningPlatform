class RegistrationsController < ApplicationController
  load_and_authorize_resource :course
  load_and_authorize_resource :registration, through: :course

  def new; end

  def create
    return unless @registration.save

    flash[:notice] = "Successfully registered to #{@course.title}"
    redirect_to user_courses_mycourses_path(current_user)
  end

  def destroy
    @registration.destroy
  end

  def registration_params
    params.require(:registration).permit(:user_id, :course_id)
  end
end
