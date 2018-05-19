class UsersController < ApplicationController
  before_action :authenticate_user
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:message] = "New User #{@user.username} created"
      redirect_to orders_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:message] = "User #{@user.username} edited"
      redirect_to orders_path
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit!
  end

end