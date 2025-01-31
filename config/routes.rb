Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest



  # Devise routes for authentication
  devise_for :users

  # Root path (Redirect to sign-in if not authenticated)
  unauthenticated do
    root to: "home#index", as: :unauthenticated_root
  end

  # Define the authenticated root path (Redirect based on role)
  authenticated :user do
    root to: "dashboards#show", as: :authenticated_root
  end

  # Home page with Admin & User sign-in options
  get "home", to: "home#index"

  # Admin routes (Restricted to admin users)
  namespace :admin do
    get "dashboard", to: "dashboards#index", as: "dashboard"  # Correct route for admin dashboard
    resources :users, only: [ :index, :show, :destroy ]  # Admin can manage users
    resource :admin_profile, only: [ :show, :update ]  # Admin profile management
  end

  # User routes (Restricted to normal users)
  namespace :user do
    get "dashboard", to: "dashboards#show", as: "dashboard"  # Correct route for user dashboard
  end

  # API routes for user profile management (JSON data)
  namespace :api do
    namespace :v1 do
      resources :users, only: [ :index, :show, :edit, :update, :destroy ]
    end
  end
end
