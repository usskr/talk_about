Rails.application.routes.draw do
  root "homes#top"
  get "sessions/new"
  get "help" => "homes#help"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users
  resources :chats, only: [:create, :index, :show]
end
