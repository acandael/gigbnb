Rails.application.routes.draw do
  devise_for :members
  root "home#index"

  resources :members do
    resources :profiles
    resources :locations
    resources :reservations
  end

  resources :locations do
    get :add_images, on: :member
  end

  resources :reservations do
    get :confirmation
  end
end
