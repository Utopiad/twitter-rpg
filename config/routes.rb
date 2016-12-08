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
    resources :game
  end


  get '/game/:world_id', to: 'game#index' do
    resources :turn
  end



  devise_for :users

  root 'yolo#index'
end
