Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: :registrations,
    sessions: :sessions
  }

  root to: 'home#index'
 
  namespace :api, defaults: { format: 'json' } do
    post 'games/start_game', to: 'games#start_game'
    post 'games/:game_id/questions/:order', to: 'questions#show'
    post 'games/:game_id/teams', to: 'teams#index'
  end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

