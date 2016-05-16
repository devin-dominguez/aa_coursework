class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # render json: params.require(:user)
    user = User.find_by_credentials(user_params)
    if user
      log_in!(user)
      # render json: user
    else
      flash[:login_error] = "User Not found!"
      redirect_to new_session_url
    end
  end

  def destroy
    log_out_user
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
