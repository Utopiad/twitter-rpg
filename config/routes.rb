Rails.application.routes.draw do
  get "world/new_character" => "world#new_character"

  resources :world do
    resources :character
    resources :stuff
    resources :monster
    resources :character_type
  end

  devise_for :users

  root 'yolo#index'
end
