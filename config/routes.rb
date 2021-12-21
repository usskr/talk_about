Rails.application.routes.draw do
  root "homes#top"
  get "help" => "homes#help"
  get "signup" => "users#new"
  resources :users
end
