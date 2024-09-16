class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: login_params[:username])
    if @user&.authenticate(login_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = 'Login failed'
      redirect_to new_user_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end
end
