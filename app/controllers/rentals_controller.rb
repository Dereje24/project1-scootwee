class RentalsController < ApplicationController
  before_action  do
      if !session[:user_id]
      redirect_to login_path
    end
   end
   before_action only:[:current] do
     if !reserved?
      redirect_to user_path
    end
   end
def create
rental=params_rental
rental[:user_id]=session[:user_id]
rental[:drop_date]='nill'
@rental=Rental.new(rental)
if(@rental.save)
redirect_to current_path
end
end
def current
  @rental=Rental.new
  @locals=Local.all
  @current_rental=User.find(session[:user_id]).rental.where("drop_date = 'nill'")
  @vehicle=@current_rental[0].vehicle
  @local=@current_rental[0].local
end
def show
@rentals=current_user.Rental.where("drop_date != 'nill' ")

end
def drop
p params_drop[:local_id]
@rental=Rental.find(params_drop[:rental_id])
if @rental.vehicle.update(local_id:params_drop[:local_id])
  if @rental.update(drop_date:'okay')
  redirect_to user_path
else
  redirect_to root_path
end
else
flash[:error]='pick another location this one is full'
end
end

def params_rental
params.permit(:local_id,:vehicle_id)

end
def params_drop
  params.require(:rental).permit(:local_id,:rental_id,:vehicle_id)
end
def reserved?
    @rental =User.find(session[:user_id]).rental.where("drop_date = 'nill'")
  if @rental.count == 0
    nil
    else
    @rental
  end
end


end
