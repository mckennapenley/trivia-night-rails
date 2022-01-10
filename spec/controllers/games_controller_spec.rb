# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::GamesController do
  context 'when question quantity is invalid' do
    let(:params_with_invalid_question_quantity) do
      {
        game: {
          question_qty: 0,
          difficulty: 'easy',
          team1: 'team1_name'
        }
      }
    end

    it 'raises error' do
      expect do
        post :start_game, params: params_with_invalid_question_quantity
      end.to raise_error(RuntimeError)
    end
  end

  context 'when difficulty is invalid' do
    let(:params_with_invalid_difficulty) do
      {
        game: {
          question_qty: 1,
          difficulty: '',
          team1: 'team1_name'
        }
      }
    end

    it 'raises error' do
      expect do
        post :start_game, params: params_with_invalid_difficulty
      end.to raise_error(RuntimeError)
    end
  end

  context 'when team name is invalid' do
    let(:params_with_invalid_team_name) do
      {
        game: {
          question_qty: 1,
          difficulty: 'easy',
          team1: ''
        }
      }
    end

    it 'raises error' do
      expect do
        post :start_game, params: params_with_invalid_team_name
      end.to raise_error(RuntimeError)
    end
  end

  context 'when params are valid' do
    valid_params = {
      game: {
        question_qty: 1,
        difficulty: 'easy',
        team1: 'team1_name'
      }
    }

    let(:question_api_response) do
      [
        { 'category' => 'General Knowledge',
          'type' => 'multiple',
          'difficulty' => 'easy',
          'question' => 'Which American-owned brewery led the country in sales by volume in 2015?',
          'correct_answer' => 'D. G. Yuengling and Son, Inc',
          'incorrect_answers' => ['Anheuser Busch', 'Boston Beer Company', 'Miller Coors'] }
      ]
    end

    before do
      expect(QuestionService).to receive(:get_questions).and_return(question_api_response)
    end

    it 'creates new Game record' do
      expect do
        post :start_game, params: valid_params
      end.to change(Game, :count).by(1)
    end

    it 'creates new Team record' do
      expect do
        post :start_game, params: valid_params
      end.to change(Team, :count).by(1)
    end

    it 'creates new Question record' do
      expect do
        post :start_game, params: valid_params
      end.to change(Question, :count).by(1)
    end

    it 'is successful' do
      post :start_game, params: valid_params

      expect(response.status).to eq(200)
    end

    it 'creates a game' do
      expect do
        post :start_game, params: valid_params
      end.to change { Game.count }.by(1)
    end

    it 'should return the created game' do
      post :start_game, params: valid_params

      parsed_response = JSON.parse(response.body).deep_symbolize_keys

      expect(parsed_response.keys).to match_array(%i[created_at id question_quantity updated_at])
    end
  end
end
