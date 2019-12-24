Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers, :subsidiaries, :car_categories, :car_models
end
