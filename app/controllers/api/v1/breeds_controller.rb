class Api::V1::BreedsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]


  def index
    breeds = Breed.kept
    if breeds.any?
      render json: { success: true, breeds: breeds }, status: :ok
    else
      render json: { success: false, message: "No breeds found" }, status: :not_found
    end
  rescue StandardError => e
    render json: { success: false, error: e.message }, status: :internal_server_error
  end
end
