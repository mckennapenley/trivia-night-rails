Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: :registrations,
    sessions: :sessions
  }

  root to: 'home#index'


  resources :games
  resources :teams
  resources :questions
 
  namespace :api, defaults: { format: 'json' } do
    post 'games/start_game', to: 'games#start_game'
    get 'games/question', to: 'games#show_question'
  end

  get '/blah', to: 'games#blah'
  get '/start_game', to: 'games#new_game'

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

