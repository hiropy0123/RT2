Rails.application.routes.draw do

  resources :users

  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get 'static_pages/help'
  get '/signup', to: 'users#new'
  post 'signup', to: 'users#create'

  root 'static_pages#home'

end
