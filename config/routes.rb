Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers, :subsidiaries, :car_categories, :car_models, :clients, :car_rentals
  resources :cars, only: [:index, :show, :new, :create]
  resources :rentals do
    get 'search', on: :collection
    get 'effect', on: :member
  end
  post '/rentals/:rental_id/effect/:car_id', to: 'car_rentals#create', as: :ready_rental
end
