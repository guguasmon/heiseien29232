Rails.application.routes.draw do
  devise_for :users
  get 'guests/index'
  root to: "guests#index"
  resources :guests
end
