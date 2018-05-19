class SessionsController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to orders_path
    else
      flash.now.alert = "username or password is invalid"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end
end