# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/games/:game_id/teams' do
  let!(:game) do
    FactoryGirl.create(:game)
  end
  let!(:team) do
    FactoryGirl.create(:team, game: game)
  end
  let!(:team2) do
    FactoryGirl.create(:team, game: game)
  end

  it 'returns a list of all teams' do
    get "/api/games/#{game.id}/teams"

    expect(json_body['teams'].count).to eq(2)

    expect(json_body['teams']).to eq(
      [
        {
          'id' => team.id,
          'name' => team.name,
          'game_id' => team.game_id,
          'score' => team.score
        },
        {
          'id' => team2.id,
          'name' => team2.name,
          'game_id' => team2.game_id,
          'score' => team2.score
        }
      ]
    )
  end
end
