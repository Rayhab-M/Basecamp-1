Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Custom routes for UsersController with restricted actions
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      patch :set_admin      # Route for setting a user as admin
      patch :remove_admin   # Route for removing admin privileges
    end
  end

  resources :projects  # Routes for project management

  # Define the root path route ("/")
  root "home#index"
  get 'search', to: 'search#index'
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end





