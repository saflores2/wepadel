Rails.application.routes.draw do
  get 'rooms/index'
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
    collection do
      get :my_chatrooms
    end
  end

  resources :participations, only: [:delete] do
    resources :payments, only: [:new, :create]
    member do
      get :payment
      get :confirmation
    end

    collection do
      get :my_participations
    end
  end

  resources :matches, only: [:update] do
    resources :games, only: [:create]
  end

  post "process_payment", to: "payments#process_payment"
  resources :payments, except: [:new, :create]

end
