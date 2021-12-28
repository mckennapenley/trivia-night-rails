require 'rails_helper'

RSpec.describe Api::QuestionsController do
  describe 'GET show' do
    let!(:game) { 
      FactoryGirl.create(:game)
    }
    let!(:question) { 
      FactoryGirl.create(:question, game: game) 
    }
    let(:params) { 
      { 
        game_id: game.id, 
        order: question.order 
      } 
    }
  
    it "is successful" do
      get :show, params: params
      
      expect(response.status).to eq(200)
    end

    it 'returns question' do
      get :show, params: params
      parsed_response = JSON.parse(response.body).deep_symbolize_keys
     
      expect(parsed_response).to eq(
        {
          id: question.id,
          points: question.points,
          prompt: question.prompt,
          answer: question.answer,
          order: question.order,
          created_at: question.created_at.as_json,
          updated_at: question.updated_at.as_json,
          game_id: question.game_id,
        }
      )
    end
  end
end
