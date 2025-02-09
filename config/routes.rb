Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Devise routes for authentication
  devise_for :users

  # Set root to admin dashboard
  root to: "admin/dashboards#index"

  # Admin routes (Restricted to admin users)
  namespace :admin do
    get "dashboard", to: "dashboards#index", as: "dashboard"
    resources :users, only: [ :index, :show ] do
      member do
        patch :discard
      end
    end
    resources :categories, only: [ :index, :new, :create, :edit, :update ] do
      member do
        patch :discard
      end
    end
    resources :breeds, only: [ :index, :new, :create, :edit, :update ] do
      member do
        patch :discard
      end
    end
    resources :pets, only: [ :index, :show, :new, :create, :edit, :update ] do
      member do
        patch :discard
      end
    end
    resources :donate_pets, only: [ :index, :show, :update ] do
    end
    resource :profile, only: [ :show, :update ]
  end

  # User routes (Restricted to normal users)
  namespace :user do
    get "dashboard", to: "dashboards#show", as: "dashboard"
  end

  # API routes for user profile management (JSON data)
  namespace :api do
    namespace :v1 do
      post "login", to: "auth#login"  # Login API
      resources :users, only: [ :show, :edit, :update, :destroy ]
    end
  end
end
