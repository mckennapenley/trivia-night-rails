class Api::GamesController < ApplicationController
  # POST /api/games
  def start_game
    game = Game.create(question_quantity: params[:game][:question_qty].to_i)
    questions = QuestionService.get_questions(params[:game][:question_qty].to_i, params[:game][:difficulty])

    
    questions.each_with_index do |question, index| 
      Question.create(
        points: 100, 
        prompt: question["question"], 
        answer: question["correct_answer"], 
        order: index + 1, 
        game_id: game.id
      )
    end

    teams = (params[:game].except(:difficulty, :question_qty)).values
    teams.each do |team|
      Team.create(
        name: team,
        game_id: game.id
      )
    end
     
    render json: game
  end

 
  def end_game
    game = Game.find(params[:game_id])
    teams = game.teams

    render json: {  
    teams: teams.map { |team| TeamSerializer.new(team) }
    }

  end
end


# def next_question
#   current_question = Question.find(22)

#   render json { question: current_question.next_question}
# end

# # Question Model
# def next_question
#   Question.find_by(game_id: self.game_id, order: self.order + 1)
# end
