Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :games do
    resources :question
  end

  resources :cars
  mount PostgresqlLoStreamer::Engine => "/car_image"

  post "games/:id", to: "games#check_answers"

  root "games#index"
end
