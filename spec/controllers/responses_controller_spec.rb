# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::ResponsesController do
  describe 'POST create' do
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
    let(:params_with_correct_response) do
      {
        game_id: game.id,
        order: question.order,
        answered_correctly: true,
        team_id: team.id
      }
    end

    context 'when an existing response exists' do
      context 'when current response is different from existing' do
        it 'is successful' do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: false)

          post :create, params: params_with_correct_response

          expect(response.status).to eq(200)
        end

        it 'updates existing response with current response' do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: false)

          expect do
            post :create, params: params_with_correct_response
          end.to change { exisiting_response.reload.answered_correctly }.from(false).to(true)
        end

        it 'returns the teams' do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: false)

          post :create, params: params_with_correct_response

          parsed_response = JSON.parse(response.body).deep_symbolize_keys

          expect(parsed_response).to eq(
            {
              teams: [
                { game_id: game.id, id: team.id, name: team.name, score: team.score },
                { game_id: game.id, id: team2.id, name: team2.name, score: team2.score }
              ]
            }
          )
        end
      end

      context 'when current response is not different from existing' do
        it 'is successful' do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: true)

          post :create, params: params_with_correct_response

          expect(response.status).to eq(200)
        end

        it 'does not update existing response' do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: true)

          post :create, params: params_with_correct_response

          expect do
            post :create, params: params_with_correct_response
          end.to_not change { exisiting_response.reload.answered_correctly }
        end

        it 'does not create a response' do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: true)

          expect do
            post :create, params: params_with_correct_response
          end.to_not change { Response.count }
        end

        it 'returns the teams' do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: true)

          post :create, params: params_with_correct_response

          parsed_response = JSON.parse(response.body).deep_symbolize_keys

          expect(parsed_response).to eq(
            {
              teams: [
                { game_id: game.id, id: team.id, name: team.name, score: team.score },
                { game_id: game.id, id: team2.id, name: team2.name, score: team2.score }
              ]
            }
          )
        end
      end
    end

    context 'when an existing response does not exist' do
      it 'is successful' do
        post :create, params: params_with_correct_response

        expect(response.status).to eq(200)
      end

      it 'creates a response' do
        expect do
          post :create, params: params_with_correct_response
        end.to change { Response.count }.by(1)
      end

      it 'returns the teams' do
        post :create, params: params_with_correct_response

        parsed_response = JSON.parse(response.body).deep_symbolize_keys

        expect(parsed_response).to eq(
          {
            teams: [
              { game_id: game.id, id: team.id, name: team.name, score: team.score },
              { game_id: game.id, id: team2.id, name: team2.name, score: team2.score }
            ]
          }
        )
      end
    end
  end
end
