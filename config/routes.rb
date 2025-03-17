Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  resources :books do
    resources :chapters
  end

  resources :chapters, only: [] do
    resources :scenes 
  end

  resources :graphs, only: :index

  resources :links

  post "search" => "search#create"
  get "up" => "rails/health#show", as: :rails_health_check

  root "books#index"
end
