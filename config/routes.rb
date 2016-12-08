Rails.application.routes.draw do

  resources :world do
    resources :character
    resources :stuff
    resources :character_type
    resources :monster do
      resources :event_monster
    end
  end

  get '/game/world/:world_id', to: 'game#index'

  # map.connect 'game/world/:world_id', :controller => 'game', :action => 'index'

  # scope path: "game", controller: :game do
  #   map.resources :world, :controller => "game"
  #   resources :world do
  #     resources :turn
  #     resources :chapter do
  #       resources :event
  #     end
  #   end
  # end



  devise_for :users

  root 'yolo#index'
end
