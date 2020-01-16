Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers, :subsidiaries, :car_categories, :car_models, :clients, :car_rentals
  resources :rentals do
    get 'search', on: :collection
    get 'effect', on: :member
  end
end
