Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'dashboard', to: 'dashboard#index'
  resources :orders
  resources :contacts
  resources :vendors
  resources :shows

end