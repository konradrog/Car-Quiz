class Question < ApplicationRecord
  belongs_to :game
  has_many :answers

  def create_answers(q_id)
    @question = Question.find(q_id)
    @car = Car.order("Random()").first
    @correct_answer = Answer.create!(question_id: q_id, car_id: @car.id, correct: true)
    other_cars = Car.where(body_style: @car.body_style).order("Random()").limit(3).to_a
    other_cars.each do |other_car|
      Answer.create!(question_id: q_id, car_id: other_car.id)
    end
  end
end
