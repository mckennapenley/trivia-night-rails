# frozen_string_literal: true

class QuestionService
  def self.get_questions(question_qty, difficulty)
    HTTParty.get(
      "https://opentdb.com/api.php?amount=#{question_qty}&category=9&difficulty=#{difficulty}&type=multiple", headers: { 'Content-Type' => 'application/json' }
    )['results']
  end
end
