Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers, :subsidiaries, :car_categories, :car_models, :clients, :rentals
  get 'search', to: 'rentals#search'
end
