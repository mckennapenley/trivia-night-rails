# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:question_quantity) }
    it {
      is_expected.to validate_numericality_of(:question_quantity)
        .is_greater_than_or_equal_to(1)
    }
  end
end
