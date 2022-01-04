require 'rails_helper'

RSpec.describe Api::GamesController do
  context 'when question quantity is invalid' do
    let(:params_with_invalid_question_quantity) {
      { 
        game: { 
          question_qty: 0, 
          difficulty: 'easy', 
          team1: 'team1_name' 
        } 
      }
    } 

    it 'raises error' do
      expect { 
        post :start_game, params: params_with_invalid_question_quantity
      }.to raise_error(RuntimeError)
    end
  end

  context 'when difficulty is invalid' do
    let(:params_with_invalid_difficulty) { 
      { 
        game: { 
          question_qty: 1, 
          difficulty: '', 
          team1: 'team1_name' 
        } 
      }
    }

    it 'raises error' do
      expect { 
        post :start_game, params: params_with_invalid_difficulty
      }.to raise_error(RuntimeError)
    end
  end

  context 'when team name is invalid' do
    let(:params_with_invalid_team_name) { 
      { 
        game: { 
          question_qty: 1, 
          difficulty: 'easy', 
          team1: '' 
        } 
      }
    }

    it 'raises error' do
      expect { 
        post :start_game, params: params_with_invalid_team_name
      }.to raise_error(RuntimeError)
    end
  end

  context 'when params are valid' do
    let(:question_api_response) {
      [{"category"=>"General Knowledge",
      "type"=>"multiple",
      "difficulty"=>"easy",
      "question"=>"Which American-owned brewery led the country in sales by volume in 2015?",
      "correct_answer"=>"D. G. Yuengling and Son, Inc",
      "incorrect_answers"=>["Anheuser Busch", "Boston Beer Company", "Miller Coors"]
    }
    ]
    }

    valid_params = { 
      game: { 
        question_qty: 1, 
        difficulty: 'easy', 
        team1: 'team1_name' 
      } 
    }

    before do
      expect(QuestionService).to receive(:get_questions).and_return(question_api_response)
    end

    it 'creates new Game record' do
      expect {
        post :start_game, params: valid_params
      }.to change(Game, :count).by(1)
    end

    it 'creates new Team record' do
      expect {
        post :start_game, params: valid_params
      }.to change(Team, :count).by(1)
    end

    it 'creates new Question record' do
      expect {
        post :start_game, params: valid_params
      }.to change(Question, :count).by(1)
    end

    it "is successful" do
      post :start_game, params: valid_params
      
      expect(response.status).to eq(200)
    end

    it 'creates a game' do
      expect { 
          post :start_game, params: valid_params
      }.to change { Game.count }.by(1)
    end

    it 'should return the created game' do
      post :start_game, params: valid_params

      parsed_response = JSON.parse(response.body).deep_symbolize_keys

      expect(parsed_response.keys).to match_array([:created_at, :id, :question_quantity, :updated_at])
    end
  end
end

