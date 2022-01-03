require 'rails_helper'

RSpec.describe QuestionService do
  context "when .get_questions is called" do
    let!(:question_qty){1}
    let!(:difficulty){'easy'}
    let(:trivia_api_url) { "https://opentdb.com/api.php?amount=#{question_qty}&category=9&difficulty=#{difficulty}&type=multiple" }
    let!(:response) {
      { 
        "results"=>["questions"] 
      }
    }
    let!(:headers){
      {
        "Content-Type"=>"application/json"
      }
    }

    it "calls HTTParty" do
      expect(HTTParty).to receive(:get).with(trivia_api_url, { headers: headers }).and_return(response)
      
      QuestionService.get_questions(question_qty, difficulty)
    end

    it "returns questions" do
      expect(HTTParty).to receive(:get).with(trivia_api_url, { headers: headers }).and_return(response)

      expect(QuestionService.get_questions(question_qty, difficulty)).to eq(["questions"])
    end
  end
end
