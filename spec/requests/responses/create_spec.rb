# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/games/:game_id/questions/:order/create' do
  let!(:game) do
    FactoryGirl.create(:game)
  end
  let!(:question) do
    FactoryGirl.create(:question, game: game)
  end
  let!(:team) do
    FactoryGirl.create(:team, game: game)
  end
  let!(:team2) do
    FactoryGirl.create(:team, game: game)
  end
  let(:params) do
    {
      game_id: game.id,
      order: question.order,
      answered_correctly: true,
      team_id: team.id
    }
  end

  it 'returns teams' do
    post "/api/games/#{game.id}/questions/#{question.order}/create", params: params

    expect(json_body['teams'].count).to eq(2)

    expect(json_body).to eq(
      {
        'teams' =>
        [
          {
            'game_id' => game.id, 'id' => team.id, 'name' => team.name, 'score' => team.score
          },
          {
            'game_id' => game.id, 'id' => team2.id, 'name' => team2.name, 'score' => team2.score
          }
        ]
      }
    )
  end
end
