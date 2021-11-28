class Api::QuestionsController < ApplicationController
  def show
    game = Game.find(params[:game_id])
    question = game.questions.find_by(order: params[:order])
    
    render json: question
  end
end
