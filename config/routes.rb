Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}

  root to: "guests#index"
  resources :guests do
    resources :comments, only: [:create, :update, :destroy]
    collection do
      get 'lookup'
    end
  end

  resources :baths, only: [:index] do
    member do
      get 'search'
    end
  end

  resources :drinks, only: [:index] do
    member do
      get 'search'
    end
  end

  resources :foods, only: [:index] do
    member do
      get 'search'
    end
  end

end
