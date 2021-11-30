class Api::ResponsesController < ApplicationController
  def create

    game = Game.find(params[:game_id])

    question_id = game.questions.find_by(order:params[:order]).id

    exisiting_response = Response.find_by(team_id:params[:team_id], question_id:question_id)

    teams = game.teams

    

    if exisiting_response && (exisiting_response.answered_correctly != params[:answered_correctly])
      exisiting_response.update!(answered_correctly: params[:answered_correctly])
    elsif !exisiting_response 
      Response.create(answered_correctly: params[:answered_correctly], team_id: params[:team_id], question_id: question_id)
    end

    render json: {  
    teams: teams.map { |team| TeamSerializer.new(team) }
    }
  end
end
