class QuestionService
  def self.get_questions(questtion_qty, difficulty)
    questions = HTTParty.get("https://opentdb.com/api.php?amount=#{questtion_qty}&category=9&difficulty=#{difficulty}&type=multiple", :headers =>{'Content-Type' => 'application/json'} )["results"]
    questions
  end
end
 