# frozen_string_literal: true

FactoryGirl.define do
  factory :question do
    game
    points 100
    prompt 'prompt'
    answer 'answer'
    order 1
  end
end
