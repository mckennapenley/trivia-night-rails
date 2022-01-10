# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Response do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:team_id) }

    it { is_expected.to validate_presence_of(:question_id) }

    it { is_expected.to validate_inclusion_of(:answered_correctly).in_array([true, false]) }
  end
end
