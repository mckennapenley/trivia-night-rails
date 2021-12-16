class Api::GamesController < ApplicationController
  before_action :validate_params, only: :start_game
  # POST /api/games
  def start_game
    questions.each_with_index do |question, index| 
      Question.create!(
        points: 100, 
        prompt: question["question"], 
        answer: question["correct_answer"], 
        order: index + 1, 
        game_id: game.id
      )
    end

    team_names.each do |team_name|
      Team.create!(
        name: team_name,
        game_id: game.id
      )
    end
     
    render json: game
  end

 
  def end_game
    game = Game.find(params[:game_id])

    render json: {  
      teams: game.teams.map { |team| TeamSerializer.new(team) }
    }

  end

  private

  def game
    @game ||= Game.create!(question_quantity: question_quantity)
  end

  def question_quantity
    @question_quantity ||= params[:game][:question_qty].to_i
  end

  def game_difficulty
    @game_difficulty ||= params[:game][:difficulty]
  end

  def questions
    @questions ||= QuestionService.get_questions(question_quantity, game_difficulty)
  end

  def team_names
    @team_names ||= params[:game].except(:difficulty, :question_qty).values
  end

  def validate_params
    raise if team_names.empty? || question_quantity < 1 || game_difficulty.blank?
  end
end

