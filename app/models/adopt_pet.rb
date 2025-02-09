class AdoptPet < ApplicationRecord
  belongs_to :pet, foreign_key: :pet_id
  belongs_to :user, foreign_key: :user_id

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  validates :pet_id, :user_id, presence: true
    # Helper method to get category and breed name
    def category_name
      pet.breed.category.category_name if pet&.breed&.category
    end

    def breed_name
      pet.breed.breed_name if pet&.breed
    end

    def pet_gender
      pet.gender == 1 ? "Male" : "Female"
    end
end
