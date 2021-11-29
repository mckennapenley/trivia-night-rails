class Api::ResponsesController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    teams = game.teams
    question_id = game.questions.find_by(order:params[:order]).id
    Response.create(answered_correctly:params[:answered_correctly], team_id:params[:team_id],question_id:question_id)
    

    render json: {  
      teams: teams.map { |team| TeamSerializer.new(team) }
    }
  end
end
