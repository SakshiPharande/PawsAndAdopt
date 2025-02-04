class Breed < ApplicationRecord
  include Discard::Model
  belongs_to :category
  validates :breed_name, presence: true
end
