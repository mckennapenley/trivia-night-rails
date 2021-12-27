# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:prompt) }

    it { is_expected.to validate_presence_of(:answer) }

    it { is_expected.to validate_presence_of(:points) }

    it { is_expected.to validate_presence_of(:order) }

    it {
      is_expected.to validate_numericality_of(:order).is_greater_than_or_equal_to(1)
    }

    it { is_expected.to validate_presence_of(:game_id) }
  end
end
