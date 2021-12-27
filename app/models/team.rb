# frozen_string_literal: true

class Team < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  validates :game_id, presence: true
  has_many :responses
  has_many :questions, through: :responses
  has_many :correctly_answered_questions,
           -> { where('responses.answered_correctly = true') }, through: :responses, source: :question

  def score
    correctly_answered_questions.sum(:points)
  end
end
