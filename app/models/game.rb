class Game < ApplicationRecord
  has_many :questions
  belongs_to :user

  validates :level, presence: true

  def self.create_questions(game_id)
    game = Game.find(game_id)

    cars = Car.order("Random()").limit(3).to_a

    3.times { game.questions.create! }

    game.questions.each_with_index do |question, i|
      answers = []
      answers << Answer.new(question_id: question.id, car: cars[i], correct: true)

      other_cars = Car.where(body_style: cars[i].body_style).where.not(id: cars[i].id).order("Random()").limit(3).to_a
      other_cars.each do |other_car|
        answers << Answer.new(question_id: question.id, car: other_car)
      end
      answers.shuffle!
      answers.each { |answer| answer.save! }
    end
  end

  def self.create_game(user, level)
    game = user.games.new
    game.level = level
    case level
    when 2
      game.score += 15
    when 3
      game.score += 30
    end
    game.save
    game
  end
end
