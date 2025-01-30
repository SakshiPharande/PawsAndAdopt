class Pet < ApplicationRecord
  belongs_to :breed
  belongs_to :category

  enum gender: { male: 0, female: 1, unknown: 2 }
  enum status: { available: 0, unavailable: 1 }

  validates :breed_id, presence: true
  validates :category_id, presence: true
end
