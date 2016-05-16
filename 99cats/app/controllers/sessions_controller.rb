class SessionsController < ApplicationController
  before_action :log_in_check, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    user_name = user_params[:user_name]
    pw = user_params[:password]
    user = User.find_by_credentials(user_name, pw)
    if user
      login_user!(user)
    else
      flash.now[:errors] = ["Incorrect username or password."]
      @user = User.new(user_name: user_name)
      render :new
    end
  end

  def destroy
    user = current_user
    if user
      user.reset_session_token!
      session[:current_user] = nil
      session[:session_token] = nil
    end
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
