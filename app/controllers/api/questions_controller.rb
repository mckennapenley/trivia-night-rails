class Api::QuestionsController < ApplicationController
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
