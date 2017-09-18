class Game < ApplicationRecord
  has_many :questions

  def self.create_questions(game_id)
    @game = Game.find(game_id)
    10.times { @game.questions.create!(game_id: game_id) }
    @questions = @game.questions
    @questions.each do |q|
      q.create_answers(q.id)
    end
  end
end
