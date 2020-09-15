Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}

  root to: "guests#index"
  resources :guests
  resources :baths
  resources :drinks
end
