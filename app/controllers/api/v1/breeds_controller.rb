class Api::V1::BreedsController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [ :index ]


  def index
    breeds = Breed.kept
    if breeds.any?
      render json: { success: true, breeds: breeds }, status: :ok
    else
      raise ActiveRecord::RecordNotFound, "No breeds found"
    end
  end
end
