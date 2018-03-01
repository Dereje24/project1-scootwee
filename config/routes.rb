Rails.application.routes.draw do
  get 'users/new'

  get 'users/show'

  get 'users/create'

  get 'users/edit'

  get 'users/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get '/contact_us', to: 'home#contact', as: 'contact'
  get '/sign_up', to: 'user#new', as: 'sign_up'
  get '/login', to: 'session#new', as: 'login'
  get '/user', to: 'user#show', as: 'user'

  post '/contact_us', to: 'home#create'
  post '/sign_up', to: 'user#create'
  post '/login', to: 'session#create'
end

#practicing github
#practicing github 2.0