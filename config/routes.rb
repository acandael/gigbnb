Rails.application.routes.draw do
  devise_for :members
  root "home#index"

  resources :members do
    resources :profiles
    resources :locations
    resources :reservations
  end

  resources :locations do
    member do
    get :add_images
    get :calendar
    get :add_available_dates
    end
  end

  resources :reservations do
    get :confirmation
  end
end
