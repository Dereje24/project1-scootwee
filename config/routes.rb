Rails.application.routes.draw do



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root => 'home#index'

  get '/home', => 'home#index'
  get '/contact_us', => 'home#contact', as: 'contact'
  get '/sign_up', => 'users#new', as: 'sign_up'
  get '/login', => 'session#new', as: 'login'
  get '/user', => 'users#show', as: 'user'

  post '/contact_us', => 'home#create'
  post '/sign_up', => 'users#create' , as: 'users'
  post '/login', => 'session#create', as:'user_login'
  get '/logout', => 'session#destroy' , as:'logout'
  get '/map' , => 'users#map'
  post '/rent', => 'rentals#create' , as:'rental'
  get 'user/reservation', => 'rentals#current', as:'current'
  post '/drop' , =>'rentals#drop' , as: 'drop'
  get '/user/history', =>'rentals#history',as:'history'
  get '/history', =>:'rentals#show'
  # get '/user/map', to: 'users#map'
end

#practicing github
#practicing github 2.0
