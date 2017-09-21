class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :car

  attr_accessor :checked
end
