# frozen_string_literal: true

module Api
  class QuestionsController < ApplicationController
    def show
      render json: question
    end

    private

    def game
      Game.find(params[:game_id])
    end

    def question
      game.questions.find_by(order: params[:order])
    end
  end
end
