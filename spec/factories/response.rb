# frozen_string_literal: true

FactoryGirl.define do
  factory :response do
    answered_correctly false
    team
    question
  end
end
