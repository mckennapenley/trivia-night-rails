require 'rails_helper'

RSpec.describe Api::GamesController do
  context 'when question quantity is invalid' do
    let(:params_with_invalid_question_quantity) do 
      { game: { question_qty: 0, difficulty: 'easy', team1: 'team1_name' } }
    end

    it 'raises error' do
      expect { 
        post :start_game, params: params_with_invalid_question_quantity
      }.to raise_error(RuntimeError)
    end
  end

  context 'when difficulty is invalid' do
    let(:params_with_invalid_difficulty) do 
      { game: { question_qty: 1, difficulty: '', team1: 'team1_name' } }
    end

    it 'raises error' do
      expect { 
        post :start_game, params: params_with_invalid_difficulty
      }.to raise_error(RuntimeError)
    end
  end

  context 'when team name is invalid' do
    let(:params_with_invalid_team_name) do 
      { game: { question_qty: 1, difficulty: 'easy', team1: '' } }
    end

    it 'raises error' do
      expect { 
        post :start_game, params: params_with_invalid_team_name
      }.to raise_error(RuntimeError)
    end
  end

  context 'when params are valid' do
     valid_params = { game: { question_qty: 1, difficulty: 'easy', team1: 'team1_name' } }

    it 'creates new Game record' do

      expect{
          post :start_game, params: valid_params
        }.to change(Game, :count).by(1)
    end

    it 'creates new Team record' do

      expect{
          post :start_game, params: valid_params
        }.to change(Team, :count).by(1)
    end

    it 'creates new Question record' do

      expect{
          post :start_game, params: valid_params
        }.to change(Question, :count).by(1)
    end
  end
    
end
