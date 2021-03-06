class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def logged_in?
    !current.nil?
  end
  def login(user,lat,lng)
    session[:user_id]=user.id
    session[:lat]=lat
    session[:lng]=lng
    cookies[:lat]=session[:lat]
    cookies[:lng]=session[:lng]
  end
  def current
    cookies[:lat]=session[:lat]
    cookies[:lng]=session[:lng]
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def has_reserved?
    !reserved.nil?
  end

  def reserved
  @current=current
  @rental =@current.rental.where("drop_date = 'nill'")
  if @rental.count == 0
    @rental=nil
    else
    @rental
  end

  end


end
