Rails.application.routes.draw do

  root 'searches#new'

  resources :searches, only: [:create]

end
