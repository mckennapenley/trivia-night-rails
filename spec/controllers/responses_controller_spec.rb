require 'rails_helper'

RSpec.describe Api::ResponsesController do
  describe 'POST create' do
     let!(:game) { 
      FactoryGirl.create(:game)
    }
    let!(:question) { 
      FactoryGirl.create(:question, game: game) 
    }
    let!(:team) { 
      FactoryGirl.create(:team, game: game) 
    }
    let!(:team2) { 
      FactoryGirl.create(:team, game: game) 
    }
    let(:params_with_correct_response) { 
      { 
        game_id: game.id, 
        order: question.order,
        answered_correctly: true, 
        team_id: team.id
      } 
    }

    context "when an existing response exists" do
      let(:exisiting_response) { FactoryGirl.create(:response, team: team, question: question, answered_correctly: false) }

      context "when current response is different from existing" do
        it "is successful" do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: false)

          post :create, params: params_with_correct_response

          expect(response.status).to eq(200)
        end

        it "updates existing response with current response" do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: false)

          expect { 
            post :create, params: params_with_correct_response
          }.to change { exisiting_response.reload.answered_correctly }.from(false).to(true)
        end

        it "returns the teams" do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: false)

          post :create, params: params_with_correct_response

          parsed_response = JSON.parse(response.body).deep_symbolize_keys

          expect(parsed_response).to eq({
            teams: [
              {game_id: game.id, id: team.id, name: team.name, score: team.score},
              {game_id: game.id, id: team2.id, name: team2.name, score: team2.score}
            ]
          })

        end
      end

      context "when current response is not different from existing" do
        it "is successful" do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: true)

          post :create, params: params_with_correct_response

          expect(response.status).to eq(200)
        end

        it "does not update existing response" do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: true)

          post :create, params: params_with_correct_response

          expect { 
            post :create, params: params_with_correct_response
          }.to_not change { exisiting_response.reload.answered_correctly }
        end

        it "does not create a response" do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: true)

          expect { 
            post :create, params: params_with_correct_response
          }.to_not change { Response.count }
        end

        it "returns the teams" do
          exisiting_response = FactoryGirl.create(:response, team: team, question: question, answered_correctly: true)

          post :create, params: params_with_correct_response
          
          parsed_response = JSON.parse(response.body).deep_symbolize_keys

          expect(parsed_response).to eq({
            teams: [
              {game_id: game.id, id: team.id, name: team.name, score: team.score},
              {game_id: game.id, id: team2.id, name: team2.name, score: team2.score}
            ]
          })
        end
      end
    end
   

    context "when an existing response does not exist" do
      it "is successful" do
       post :create, params: params_with_correct_response
     
       expect(response.status).to eq(200)
      end

      it "creates a response" do
        expect { 
          post :create, params: params_with_correct_response
        }.to change { Response.count }.by(1)
      end
      
      it "returns the teams" do
        post :create, params: params_with_correct_response
          
        parsed_response = JSON.parse(response.body).deep_symbolize_keys

        expect(parsed_response).to eq({
          teams: [
            {game_id: game.id, id: team.id, name: team.name, score: team.score},
            {game_id: game.id, id: team2.id, name: team2.name, score: team2.score}
          ]
        })
      end
    end
  end
end
