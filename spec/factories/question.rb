# frozen_string_literal: true

FactoryGirl.define do
  factory :question do
    points 100
    prompt 'prompt'
    answer 'answer'
    order 1
    game_id 1
  end
end
