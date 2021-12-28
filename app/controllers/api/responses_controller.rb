# frozen_string_literal: true

module Api
  class ResponsesController < ApplicationController
    def create
      if different_from_previous_response?
        exisiting_response.update!(answered_correctly: params[:answered_correctly])
      elsif !exisiting_response
        Response.create(answered_correctly: params[:answered_correctly], team_id: params[:team_id],
                        question_id: question_id)
      end

      render json: {
        teams: teams.map { |team| TeamSerializer.new(team) }
      }
    end

    private

    def game
      @game ||= Game.find(params[:game_id])
    end

    def exisiting_response
      @exisiting_response ||= Response.find_by(team_id: params[:team_id], question_id: question_id)
    end

    def teams
      game.teams
    end

    def question_id
      game.questions.find_by(order: params[:order]).id
    end

    def different_from_previous_response?
      exisiting_response && exisiting_response.answered_correctly != params[:answered_correctly]
    end
  end
end
