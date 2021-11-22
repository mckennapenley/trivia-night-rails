class Response < ApplicationRecord
  belongs_to :team
  belongs_to :question
  validates :team_id, presence: true
  validates :question_id, presence: true

  scope :correct, -> { where(answered_correctly: true) }
end
