# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/games/start_game' do
  context 'when params are valid' do
    let(:question_api_response) do
      [
        {
          'category' => 'General Knowledge',
          'type' => 'multiple',
          'difficulty' => 'easy',
          'question' => 'Which American-owned brewery led the country in sales by volume in 2015?',
          'correct_answer' => 'D. G. Yuengling and Son, Inc',
          'incorrect_answers' => ['Anheuser Busch', 'Boston Beer Company', 'Miller Coors']
        }
      ]
    end

    before do
      expect(QuestionService).to receive(:get_questions).and_return(question_api_response)
    end

    it 'creates the game' do
      params = {
        game: {
          question_qty: '1',
          difficulty: 'easy',
          team1: 'team1_name'
        }
      }
      post '/api/games/start_game', params: params
      expect(response.status).to eq 200
      expect(Game.last.question_quantity).to eq params[:game][:question_qty].to_i
    end

    it 'creates the question' do
      params = {
        game: {
          question_qty: '1',
          difficulty: 'easy',
          team1: 'team1_name'
        }
      }

      post '/api/games/start_game', params: params
      expect(question_api_response[0]['question']).to eq(Question.last.prompt)
    end

    it 'creates the team' do
      params = {
        game: {
          question_qty: '1',
          difficulty: 'easy',
          team1: 'team1_name'
        }
      }

      post '/api/games/start_game', params: params
      expect(Team.last.name).to eq params[:game][:team1]
    end
  end

  context 'when there are invalid params' do
    it 'raises error' do
      invalid_params = {
        game: {
          question_qty: '0',
          difficulty: '',
          team1: ''
        }
      }

      expect do
        post '/api/games/start_game', params: invalid_params
      end.to raise_error(RuntimeError)
    end
  end
end
