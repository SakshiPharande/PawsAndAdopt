class Breed < ApplicationRecord
  include Discard::Model
  belongs_to :category
  has_many :pets

  validates :breed_name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters" }
  validates :category_id, presence: true
end
