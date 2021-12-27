# frozen_string_literal: true

class Question < ApplicationRecord
  validates :prompt, presence: true, allow_blank: false
  validates :answer, presence: true, allow_blank: false
  validates :points, presence: true
  validates :order, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :game_id, presence: true
  
  has_many :responses
  has_many :teams, through: :responses
end
