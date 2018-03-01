class SessionController < ApplicationController
  before_action  do
      if logged_in?
      redirect_to user_path
    end
  end

  def new
    @user=User.new
  end
  def create
  @user=User.find_by(email:params_login[:email])
    if(@user && @user.authenticate(params_login[:password]))
      login(@user)
      redirect_to user_path
    else
      flash[:error]="Wrong Combination of Username and Password"
      redirect_to login_path
    end
  end
  def destroy
    reset_session
      @current_user = nil
    redirect_to root_path
  end
  private def params_login
    params.permit(:email,:password)
  end
end
