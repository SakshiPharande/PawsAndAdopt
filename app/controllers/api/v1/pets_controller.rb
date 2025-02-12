class Api::V1::PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]  # Public access

  def index
    pets = Pet.kept.includes(:breed, :category)

    if pets.any?
      render json: {
        success: true,
        pets: pets.map do |pet|
          {
            id: pet.id,
            age: pet.age,
            gender: pet.gender.capitalize,
            temperament: pet.temperament,
            vaccination_status: pet.vaccination_status,
            medical_history: pet.medical_history,
            recommended_food: pet.recommended_food,
            common_health_issues: pet.common_health_issues,
            status: pet.status.capitalize,
            pet_image_url: pet.pet_image_url,
            breed_name: pet.breed.breed_name,
            category_name: pet.category.category_name
          }
        end
      }, status: :ok
    else
      render json: { success: false, message: "No pets found" }, status: :not_found
    end
  rescue StandardError => e
    render json: { success: false, error: e.message }, status: :internal_server_error
  end
end
