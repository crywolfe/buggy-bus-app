Rails.application.routes.draw do

  root 'searches#index'

  resources :searches

  # resources :buggy_buses


end
