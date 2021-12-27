# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :teams
  has_many :questions

  validates :question_quantity, presence: true
  validates :question_quantity, numericality: { greater_than_or_equal_to: 1 }
end
