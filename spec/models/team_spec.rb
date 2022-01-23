# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:game_id) }
  end

  describe '#score' do
    context 'when there are no correctly answered questions' do
      let(:team) { FactoryGirl.build(:team) }

      it 'calculates score' do
        expect(team.score).to eq(0)
      end
    end

    context 'when there are correctly answered questions' do
      let!(:team) { FactoryGirl.create(:team) }
      let!(:question) { FactoryGirl.create(:question) }
      let!(:response) { FactoryGirl.create(:response, answered_correctly: true, team: team, question: question) }

      it 'calculates score' do
        expect(team.score).to eq(100)
      end
    end
  end
end
