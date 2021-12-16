class Game < ApplicationRecord
  has_many :teams
  has_many :questions

  validates :question_quantity, numericality: { greater_than: 0 }
end
