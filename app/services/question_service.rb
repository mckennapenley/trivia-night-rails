# frozen_string_literal: true

class QuestionService
  def self.get_questions(questtion_qty, difficulty)
    HTTParty.get(
      "https://opentdb.com/api.php?amount=#{questtion_qty}&category=9&difficulty=#{difficulty}&type=multiple", headers: { 'Content-Type' => 'application/json' }
    )['results']
  end
end
