# frozen_string_literal: true

class Response < ApplicationRecord
  belongs_to :team
  belongs_to :question

  validates :team_id, presence: true
  validates :question_id, presence: true
  validates :answered_correctly, inclusion: { in: [true, false] }
end
