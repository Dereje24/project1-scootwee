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
    @user = User.new({first_name:user_params[:first_name],last_name:user_params[:last_name],email:user_params[:email],password:user_params[:password]})
    if(@user.save)
      login(@user,user_params[:lat],user_params[:lng])
    redirect_to user_path
  end
  end

  def edit
  end

  def destroy
  end
  def map
  @positions=  ActiveRecord::Base.connection.execute("SELECT *,(((acos(sin((#{cookies['lat'].to_f} * pi()/180)) *
            sin((CAST(lat AS DOUBLE PRECISION) * pi()/180))+cos((#{cookies['lat'].to_f} * pi()/180)) *
            cos((CAST(lat AS DOUBLE PRECISION) *pi()/180)) * cos(((#{cookies['lng'].to_f} - CAST(lng AS DOUBLE PRECISION))*
            pi()/180))))*180/pi())*60*1.1515
        ) as distance FROM locals ORDER BY distance ASC limit 15")

    render json: {status: 'SUCCESS' , data: @positions}, status: :ok

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :lat, :lng )
  end
end
