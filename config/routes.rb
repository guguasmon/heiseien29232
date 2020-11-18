Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}
devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#new_guest'
end

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

  resources :foods, only: [:index] 

end
