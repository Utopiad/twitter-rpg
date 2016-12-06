Rails.application.routes.draw do
  get "world/new_character" => "world#new_character"

  resources :world
  resources :character
  resources :stuff
  resources :monster
  resources :classe

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'yolo#index'
end
