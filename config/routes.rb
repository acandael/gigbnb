Rails.application.routes.draw do
  devise_for :members, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root "home#index"

  resources :members do
    get :payout_account, on: :member
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
