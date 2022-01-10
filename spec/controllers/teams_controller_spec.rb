# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::TeamsController do
  describe 'GET index' do
    let!(:game) do
      FactoryGirl.create(:game)
    end
    let!(:team) do
      FactoryGirl.create(:team, game: game)
    end
    let!(:team2) do
      FactoryGirl.create(:team, game: game)
    end
    let(:params) do
      {
        game_id: game.id
      }
    end

    it 'is successful' do
      get :index, params: params

      expect(response.status).to eq(200)
    end

    it 'returns the teams' do
      get :index, params: params

      parsed_response = JSON.parse(response.body).deep_symbolize_keys

      expect(parsed_response).to eq({
                                      game: {
                                        created_at: game.created_at.as_json,
                                        id: game.id,
                                        question_quantity: game.question_quantity,
                                        updated_at: game.updated_at.as_json
                                      },
                                      teams: [
                                        { game_id: game.id, id: team.id, name: team.name, score: team.score },
                                        { game_id: game.id, id: team2.id, name: team2.name, score: team2.score }
                                      ]
                                    })
    end
  end
end
