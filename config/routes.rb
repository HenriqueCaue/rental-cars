Rails.application.routes.draw do
  root 'home#index' #> RAIZ ou seja ROOT
  # get '/', to: 'home#index'
  #resources :manufacturers, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :manufacturers
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_categories, only: [:index, :show, :new, :create]
  resources :customers, only: [:index, :show, :new, :create]
  resources :car_models, only: [:index, :show, :new, :create]
end
