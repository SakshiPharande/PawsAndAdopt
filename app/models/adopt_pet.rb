class AdoptPet < ApplicationRecord
  belongs_to :pet, foreign_key: :pet_id
  belongs_to :breed, foreign_key: :breed_id
  belongs_to :user, foreign_key: :user_id

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  validates :pet_id, :breed_id, :user_id, presence: true
end
