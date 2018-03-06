Rails.application.routes.draw do



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get '/home', to: 'home#index'
  get '/contact_us', to: 'home#contact', as: 'contact'
  get '/sign_up', to: 'users#new', as: 'sign_up'
  get '/login', to: 'session#new', as: 'login'
  get '/user', to: 'users#show', as: 'user'

  post '/contact_us', to: 'home#create'
  post '/sign_up', to: 'users#create' , as: 'users'
  post '/login', to: 'session#create', as:'user_login'
  get '/logout', to: 'session#destroy' , as:'logout'
  get '/map' , to: 'users#map'
  post '/rent', to: 'rentals#create' , as:'rental'
  get 'user/reservation', to: 'rentals#current', as:'current'
  post '/drop' , to:'rentals#drop' , as: 'drop'
  get '/user/history', to:'rentals#history',as:'history'
  get '/history', to:'rentals#show'
  # get '/user/map', to: 'users#map'
end

#practicing github
#practicing github 2.0
