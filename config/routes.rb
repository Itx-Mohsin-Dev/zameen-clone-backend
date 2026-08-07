Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  get "up" => "rails/health#show", as: :rails_health_check
  # root to: "home#index"
  resources :properties do
    collection do
      get :my_listings
      get :pending
      delete :bulk_destroy
    end

    member do
      patch :approve
      patch :reject
    end
  end
  resources :favorites, only: [ :index, :create, :destroy ]
  resources :inquiries, only: [ :index, :show, :create ]
  resources :users, only: [:index, :destroy]
  get "/profile", to: "users#profile"
  get "/dashboard", to: "dashboard#index"
end
