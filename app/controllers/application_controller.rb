class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def logged_in?
    !current.nil?
  end
  def login(user)
    session[:user_id]=user.id
  end
  def current
    @current_user ||= User.find_by(id: session[:user_id])
  end

end
