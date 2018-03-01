class UsersController < ApplicationController
before_action only:[:show] do
  if !logged_in?
    redirect_to login_path
  end
 end
 before_action only:[:new] do
   if logged_in?
     redirect_to user_path
   end
  end

  def index
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
