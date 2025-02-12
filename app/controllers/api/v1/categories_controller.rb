class Api::V1::CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    categories = Category.kept  # Fetch only kept categories
    if categories.any?
      render json: { success: true, categories: categories }, status: :ok
    else
      render json: { success: false, message: "No categories found" }, status: :not_found
    end
  rescue StandardError => e
    render json: { success: false, error: e.message }, status: :internal_server_error
  end
end
