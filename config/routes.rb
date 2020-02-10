Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :manufacturers, :subsidiaries, :car_categories, :car_models, :clients
  resources :car_rentals, only: [:show, :create]
  resources :cars, only: [:index, :show, :new, :create]
  get 'new_csv_car', to: 'cars#new_csv'
  post 'create_csv', to: 'cars#create_csv'
  resources :rentals do
    get 'search', on: :collection
    get 'effect', on: :member
    resources :car_rentals, only: [:create]
  end

  namespace 'api' do
    namespace 'v1' do
      resources :cars, only: [:show, :index, :create, :update] do
        patch 'status', on: :member
      end  
    end
  end
  
end
