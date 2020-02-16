Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  get 'new_csv_car', to: 'cars#new_csv'
  post 'create_csv', to: 'cars#create_csv'
  resources :manufacturers, :subsidiaries, :car_categories, :car_models, :clients
  resources :car_rentals, only: [:show, :create]
  resources :cars, only: [:index, :show, :new, :create]
  resources :accessories, only: [:index, :show, :new, :create]
  resources :rentals do
    get 'search', on: :collection
    get 'effect', on: :member
    get 'cancel', on: :member
    get 'new_accessory', on: :member
    post 'create_accessory', on: :member
    patch 'finish_cancel', on: :member
    get 'report', on: :collection
    post 'generate_report', on: :collection
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
