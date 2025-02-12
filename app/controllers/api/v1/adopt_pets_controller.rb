class Api::V1::AdoptPetsController < Api::V1::BaseController
  def index
    adopt_pets = current_user.adopt_pets.includes(pet: [ :breed, :category ])

    if adopt_pets.exists?
      render json: {
        success: true,
        data: adopt_pets.as_json(
          only: [ :id, :email, :address, :phone_no, :status, :expected_adoption_date, :actual_adoption_date ],
          include: {
            pet: {
              only: [ :id, :age, :gender, :temperament, :vaccination_status, :pet_image_url ],
              methods: [ :gender, :category_name, :breed_name ]
            }
          }
        )
      }, status: :ok
    else
      raise ActiveRecord::RecordNotFound, "No adoption requests found for this user."
    end
  end
end
