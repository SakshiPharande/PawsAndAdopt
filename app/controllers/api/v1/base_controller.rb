# app/controllers/api/v1/base_controller.rb (optional)
class Api::V1::BaseController < ActionController::API
  include JwtHelper

  # skip_before_action :verify_authenticity_token  # Disable CSRF for API requests
  before_action :authenticate_user

  private

  def authenticate_user
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded = decode_token(token)

    if decoded
      @current_user = User.find_by(id: decoded[:user_id])
    else
      render json: { error: "Unauthorized: Please login first" }, status: :unauthorized
    end
  end
end
