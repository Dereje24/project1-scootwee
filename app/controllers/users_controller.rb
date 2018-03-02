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

<<<<<<< HEAD
  def create
    @user = User.create(user_params)
    redirect_to login_path
  end
=======

>>>>>>> map2

  def edit
  end

  def destroy
  end
  def map
    @user = User.all
    puts 'this call has been made by AJAX'

    render json: {status: 'SUCCESS' , data: @user}, status: :ok

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
