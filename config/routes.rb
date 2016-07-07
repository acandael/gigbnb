Rails.application.routes.draw do
  devise_for :members
  root "home#index"

  resources :members do
    resources :profiles
    resources :locations
  end

  resources :locations do
    get :add_images, on: :member
  end

end
