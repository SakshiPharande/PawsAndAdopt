class Breed < ApplicationRecord
  include Discard::Model
  belongs_to :category
  has_many :pets
  validates :breed_name, presence: true
end
