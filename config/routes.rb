Rails.application.routes.draw do
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
