class SessionsController < ApplicationController
  def destroy
    log_out!
    redirect_to new_session_url
  end

  def new
  end

  def create
    username = params[:user][:username]
    password = params[:user][:password]
    user = User.find_by_credentials(username, password)

    if user
      log_in!(user)
      redirect_to users_url
    else
      flash[:errors] = ["Invalid Username or Password"]
      redirect_to new_session_url
    end
  end
end
