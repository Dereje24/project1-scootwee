Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get '/contact_us', to: 'home#contact', as: 'contact'
  get '/sign_up', to: 'users#new', as: 'sign_up'
  get '/login', to: 'session#new', as: 'login'
  get '/user', to: 'users#show', as: 'user'

  post '/contact_us', to: 'home#create'
  post '/sign_up', to: 'users#create'
  post '/login', to: 'session#create'
end

#practicing github
#practicing github 2.0