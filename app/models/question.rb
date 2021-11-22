class Question < ApplicationRecord
  has_many :responses
  has_many :teams, through: :responses
  
 
end
