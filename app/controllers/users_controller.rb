class UsersController < ApplicationController
before_action do
  if !logged_in?
    redirect_to login_path
  end
end
  def new
    @user = User.new
  end

  def show
  
  end

  def create
  end

  def edit
  end

  def destroy
  end
end
