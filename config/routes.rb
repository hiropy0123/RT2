Rails.application.routes.draw do

  resources :users

  get 'static_pages/about'
  get 'static_pages/contact'
  get 'static_pages/help'

  root 'static_pages#home'

end
