class Team < ApplicationRecord
  has_many :responses    
  has_many :questions, through: :responses
  has_many :correctly_answered_questions, 
    -> { where("responses.answered_correctly = true") }, through: :responses, source: :question

 
  # def correctly_answered_questions
  #   Question.where(id: responses.correct.pluck(:question_id))
  # end

  def get_score
    self.correctly_answered_questions.sum(:points)
  end
end
