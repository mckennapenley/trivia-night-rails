# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    context 'when name is a blank string' do
      let(:team) { FactoryGirl.build(:team, name: '') }

      it 'is not valid' do
        expect(team.valid?).to eq(false)
      end
    end

    it { is_expected.to validate_presence_of(:game_id) }
  end

  describe '#score' do
    context 'when there are no correctly answered questions' do
      let(:team) { FactoryGirl.build(:team) }

      it 'calculates score' do
        team.score
        expect(team.score).to eq(0)
      end
    end

    context 'when there are correctly answered questions' do
      let!(:game) { FactoryGirl.create(:game) }
      let!(:team) { FactoryGirl.create(:team) }
      let!(:question) { FactoryGirl.create(:question) }
      let!(:response) { FactoryGirl.create(:response, answered_correctly: true, team: team, question: question, game: game) }

      it 'calculates score' do
        team.score
        expect(team.score).to eq(100)
      end
    end
  end
end