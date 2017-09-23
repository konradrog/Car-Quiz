Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "games#index"
  resources :games do
    resources :question
  end

  resources :cars
  mount PostgresqlLoStreamer::Engine => "/car_image"

  post "games/:id", to: "games#check_answers"


end
