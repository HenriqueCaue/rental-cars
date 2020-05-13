Rails.application.routes.draw do
  devise_for :users
  root 'home#index' #> RAIZ ou seja ROOT
  # get '/', to: 'home#index'
  #resources :manufacturers, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :manufacturers
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_categories, only: [:index, :show, :new, :create, :edit, :update]
  resources :customers, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
  end
  resources :car_models, only: [:index, :show, :new, :create]
  resources :rentals, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
    resources :car_rentals, only: [:new, :create]
  end
  resources :cars, only: [:index, :show, :new, :create]

  #get 'api/v1/cars', to: 'api#cars'

  namespace :api do
    namespace :v1 do
      resources :cars, only: %i[index]
    end
  end
end
