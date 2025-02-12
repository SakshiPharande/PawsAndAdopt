class Api::V1::DonatePetsController < Api::V1::BaseController
  def index
    donate_pets = current_user.donate_pets.includes(pet: [ :breed, :category ])

    if donate_pets.exists?
      render json: {
        success: true,
        data: donate_pets.as_json(
          only: [ :id, :address, :phone_no, :status, :pet_donate_date ],
          include: {
            pet: {
              only: [ :id, :age, :gender, :temperament, :vaccination_status, :pet_image_url ],
              methods: [ :gender, :category_name, :breed_name ]
            }
          }
        )
      }, status: :ok
    else
      raise ActiveRecord::RecordNotFound, "No donated pets found for this user."
    end
  end
end
