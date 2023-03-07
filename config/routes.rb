Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :tournaments do
    resources :participations, only: [:create]
    collection do
      get :my_tournaments
      get :fixture
    end
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
end
