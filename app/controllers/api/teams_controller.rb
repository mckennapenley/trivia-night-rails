class Api::TeamsController < ApplicationController
  def index
    render json: { 
      game: game, 
      teams: teams.map { |team| TeamSerializer.new(team) }
    }
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end

  def teams
    teams = game.teams
  end


end
