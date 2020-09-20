Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}

  root to: "guests#index"
  resources :guests do
    resources :comments, only: [:create, :update, :destroy]
    member do
      get 'search'
    end
  end

  resources :baths, only: [:index, :edit, :update] do
    member do
      get 'search'
    end
  end
  resources :drinks, only: [:index, :edit, :update] do
    member do
      get 'search'
    end
  end

end
