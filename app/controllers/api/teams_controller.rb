# frozen_string_literal: true

module Api
  class TeamsController < ApplicationController
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
      game.teams
    end
  end
end
