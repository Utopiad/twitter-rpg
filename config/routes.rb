Rails.application.routes.draw do
  resources :world do
    post "/activate_chapter" => "game#activate_chapter"
    post "/activate_event" => "game#activate_event"
    resources :character
    resources :stuff
    resources :character_type
    resources :monster
    resources :reward

    resources :chapter
    resources :event
    resources :event_monster
    resources :turn
    resources :game do
      # post "world#activate_chapter"
    end
  end



  devise_for :users

  mount ActionCable.server => '/cable'

  root 'home#index'
end
