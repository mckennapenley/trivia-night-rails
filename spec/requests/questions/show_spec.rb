# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/games/:game_id/questions/:order' do
  let!(:game) do
    FactoryGirl.create(:game)
  end
  let!(:question) do
    FactoryGirl.create(:question, game: game)
  end

  it 'returns the question' do
    get "/api/games/#{game.id}/questions/#{question.order}"

    expect(json_body).to eq(
      {
        'id' => question.id,
        'points' => question.points,
        'prompt' => question.prompt,
        'answer' => question.answer,
        'order' => question.order,
        'created_at' => question.created_at.as_json,
        'updated_at' => question.updated_at.as_json,
        'game_id' => question.game_id
      }
    )
  end
end
