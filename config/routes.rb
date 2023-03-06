Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :tournaments
    resources :participations, only: [:create]
    collection do
      get :my_tournaments
      get :fixture
    end

  resources :participations, only: [:delete] do
    member do
      get :payment
      get :confirmation
    end

    collection do
      get :my_participations
    end
end
