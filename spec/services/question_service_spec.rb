# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionService do
  describe '.get_questions' do
    let!(:question_qty) { 1 }
    let!(:difficulty) { 'easy' }
    let(:trivia_api_url) do
      "https://opentdb.com/api.php?amount=#{question_qty}&category=9&difficulty=#{difficulty}&type=multiple"
    end
    let!(:response) do
      {
        'results' => ['questions']
      }
    end
    let!(:headers) do
      {
        'Content-Type' => 'application/json'
      }
    end

    it 'calls HTTParty' do
      expect(HTTParty).to receive(:get).with(trivia_api_url, { headers: headers }).and_return(response)

      QuestionService.get_questions(question_qty, difficulty)
    end

    it 'returns questions' do
      expect(HTTParty).to receive(:get).with(trivia_api_url, { headers: headers }).and_return(response)

      expect(QuestionService.get_questions(question_qty, difficulty)).to eq(['questions'])
    end
  end
end
