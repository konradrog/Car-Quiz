class Game < ApplicationRecord
  has_many :questions
  belongs_to :user

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
end
