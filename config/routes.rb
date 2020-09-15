Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}

  root to: "guests#index"
  resources :guests
  resources :baths, only: [:index, :edit, :update]
  resources :drinks, only: [:index, :edit, :update]
end
