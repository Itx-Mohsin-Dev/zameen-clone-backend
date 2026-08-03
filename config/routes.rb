Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # root to: "home#index"
  resources :properties do
    collection do
      get :my_listings
      get :pending
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
