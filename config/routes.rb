Rails.application.routes.draw do
  devise_for :users

  root to: "games#index"
  resources :games do
    resources :question
  end
  resources :cars

  mount PostgresqlLoStreamer::Engine => "/car_image"

  post "games/:id", to: "games#check_answers"
  #get "users/:id" => "users#show"
  resources :users


end
