Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers, :subsidiaries, :car_categories, :car_models, :clients
  resources :rentals do
    get 'search', on: :collection
  end
end
