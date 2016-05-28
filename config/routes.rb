Rails.application.routes.draw do
  devise_for :members
  root "home#index"

  resources :members do
    resources :profiles
  end
end
