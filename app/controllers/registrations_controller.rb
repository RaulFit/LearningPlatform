class RegistrationsController < ApplicationController
  load_and_authorize_resource

  def create
    @registration.create
  end

  def destroy
    @registration.destroy
  end

  def registration_params
    params.require(:registration).permit(:user_id, :course_id)
  end
end
