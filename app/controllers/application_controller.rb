class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?
  private
  def logged_in?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    if !logged_in?
      flash.now[:notice] = "Please Log in"
      redirect_to login_path
    else
      @current_user = User.find(session[:user_id])
    end
  end
end
