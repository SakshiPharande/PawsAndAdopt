class Api::V1::AdoptPetsController < Api::V1::BaseController
  # Show all adoption requests with pet images (current user)
  def show_adoptions
    adopt_pets = current_user.adopt_pets.includes(pet: [ :breed, :category ])

    if adopt_pets.exists?
      render json: {
        success: true,
        data: adopt_pets.map { |adoption| adoption_data(adoption) }
      }, status: :ok
    else
      render json: { success: false, message: "No adoption requests found." }, status: :not_found
    end
  end

  private
  def adoption_data(adoption)
    {
      id: adoption.id,
      status: adoption.status,
      expected_adoption_date: adoption.expected_adoption_date,
      actual_adoption_date: adoption.actual_adoption_date,
      pet: {
        id: adoption.pet.id,
        age: adoption.pet.age,
        gender: adoption.pet.gender.capitalize,
        temperament: adoption.pet.temperament,
        vaccination_status: adoption.pet.vaccination_status,
        pet_images: adoption.pet.pet_images_urls,
        breed_name: adoption.pet.breed_name,
        category_name: adoption.pet.category_name
      }
    }
  end
end
