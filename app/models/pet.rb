class Pet < ApplicationRecord
  include Discard::Model
  belongs_to :breed
  belongs_to :category

  enum gender: { male: 1, female: 2, unknown: 0 }
  enum status: { available: 0, unavailable: 1 }

  validates :category_id, :breed_id, :age, :gender, :temperament, :status, presence: true
  validates :vaccination_status, inclusion: { in: [ true, false ] }
end
