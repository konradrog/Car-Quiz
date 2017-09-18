class Game < ApplicationRecord
  has_many :questions

  def self.create_questions(game_id)
    @game = Game.find(game_id)

    @cars = Car.order("Random()").limit(3).to_a

    3.times { @game.questions.create! }

    @game.questions.each_with_index do |question, i|
      @correct_answer = Answer.create!(question_id: question.id, car: @cars[i], correct: true)

      other_cars = Car.where(body_style: @cars[i].body_style).where.not(id: @cars[i].id).order("Random()").limit(3).to_a
      other_cars.each do |other_car|
        Answer.create!(question_id: question.id, car: other_car)
      end
    end
  end
end
