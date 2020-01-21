Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers, :subsidiaries, :car_categories, :car_models, :clients
  resources :car_rentals, only: [:show, :create]
  resources :cars, only: [:index, :show, :new, :create]
  resources :rentals do
    get 'search', on: :collection
    get 'effect', on: :member
    resources :car_rentals, only: [:create]
  end
end
