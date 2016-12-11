Rails.application.routes.draw do
  resources :world do
    resources :character
    resources :stuff
    resources :character_type
    resources :monster
    resources :chapter do
      resources :event do
        resources :reward
        resources :event_monster
        resources :turn
      end
    end
    resources :game do
      # post "world#activate_chapter"
    end
  end
  post "/activate_chapter" => "game#activate_chapter"
  post "/activate_event" => "game#activate_event"


  devise_for :users

  root 'yolo#index'
end
