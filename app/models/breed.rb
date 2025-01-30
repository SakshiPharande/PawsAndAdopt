class Breed < ApplicationRecord
  belongs_to :category
  validates :breed_name, presence: true
end
