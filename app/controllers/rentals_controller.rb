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
  @history=[]
@rentals=User.find(session[:user_id]).rental.where("drop_date != 'nill' ")
@rentals.each do |r|
  @vehicle=r.vehicle
  @local_start=@vehicle.local
  @local_end=Local.find(21)
  @history.push({rental:r,vehicle:@vehicle,local_start:@local_start,local_end:@local_end})

end
render json: {status: 'SUCCESS' , data: @history}, status: :ok
end

def drop
@rental=Rental.find(params_drop[:rental_id])
if @rental.vehicle.update(local_id:params_drop[:local_id])
  if @rental.update(drop_date:Date.today.to_time.to_s)
    @rental.update(local_drop:params_drop[:local_id])
  redirect_to user_path
else
  redirect_to current_path
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
