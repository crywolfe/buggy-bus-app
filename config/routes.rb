Rails.application.routes.draw do

  root 'searches#index'

  resources :searches

  post "/" => "searches#create"
  # resources :buggy_buses


end
