class Question < ApplicationRecord
  belongs_to :game
  has_many :answers

  def correct_answer
    answers.find_by(correct: true)
  end
end
