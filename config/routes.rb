Rails.application.routes.draw do
  get "world/new_character" => "world#new_character"

  resources :world do
    get "game" => "game#index"
    resources :character
    resources :stuff
    resources :character_type
    resources :monster do
      resources :event_monster
    end
  end

  devise_for :users

  root 'yolo#index'
end
