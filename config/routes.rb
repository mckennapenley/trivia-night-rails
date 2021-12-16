Rails.application.routes.draw do
  

  root to: 'home#index'
 
  namespace :api, defaults: { format: 'json' } do
    post 'games/start_game', to: 'games#start_game'
    get 'games/:game_id/questions/:order', to: 'questions#show'
    get 'games/:game_id/teams', to: 'teams#index'
    post 'games/:game_id/questions/:order/create', to: 'responses#create'
    post 'games/:game_id/end_game', to: 'games#end_game'
  end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

