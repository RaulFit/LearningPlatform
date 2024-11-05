class UsersController < ApplicationController
  load_and_authorize_resource

  def show; end

  def new; end

  def create
    if @user.save
      flash[:notice] = t(:user_notice)
      redirect_to new_user_session_path
    else
      flash[:alert] = t(:user_alert)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
