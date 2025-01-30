class DonatePet < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :pet, foreign_key: :pet_id

  enum status: { available: 0, unavailable: 1 }

  validates :user_id, :pet_id, presence: true
end
