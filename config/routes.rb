Rails.application.routes.draw do
  get 'guests/index'
  root to: "guests#index"
  resources :guests
end
