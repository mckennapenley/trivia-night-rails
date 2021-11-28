class Api::TeamsController < ApplicationController
  def index
    game = Game.find(params[:game_id])
    teams = game.teams

    render json: {
      game: game,  
      teams: teams, each_serializer: TeamSerializer
    }
  
  end
end
