class ApplicationController < ActionController::Base
  # CRLLL

  # C
  def current_user
    # finds a user by the session_token
    # we get the session_token from the session object
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  # R
  def require_logged_in
    # redirect them to login page if they are not logged in
    redirect_to new_session_url unless logged_in?
  end

  def require_logged_out
    redirect_to users_url if logged_in?
  end

  # L
  def login(user)
    # login the user
    # make the user's session token match the session's session_token
    session[:session_token] = user.reset_session_token!
  end

  # L
  def logout!
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
    @current_user = nil
  end

  # L
  def logged_in?
    !!current_user
    # !current_user.nil?
  end
end
