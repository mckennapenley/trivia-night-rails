# frozen_string_literal: true

FactoryGirl.define do
  factory :response do
    team
    question
    answered_correctly false 
  end
end
