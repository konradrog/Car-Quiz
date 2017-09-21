class Car < ApplicationRecord
  has_many :answers
  mount_uploader :image, ImageUploader
end
