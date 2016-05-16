class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    token = session[:session_token]
    User.find_by(session_token: token)
  end

  def log_out_user
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
    redirect_to user_url(user)
  end

  def login_check
    redirect_to new_session_url unless current_user
  end
end
