Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :tournaments do
    resources :participations, only: [:create]
    resources :chatrooms, only: [:create]
    collection do
      get :my_tournaments
    end
    member do
      get :fixture
    end
  end

  resources :chatrooms, only: [:show] do
    resources :messages, only: :create
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

  resources :chatrooms, only: [:show, :create ] do
    resources :messages, only: :create
  end

  resources :matches, only: [:update] do
    resources :games, only: [:create]
  end
end
