Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root "games#index", as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :games do
    resources :question
  end

  resources :cars
  mount PostgresqlLoStreamer::Engine => "/car_image"

  post "games/:id", to: "games#check_answers"


end
