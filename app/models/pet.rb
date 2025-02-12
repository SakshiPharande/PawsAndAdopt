class Pet < ApplicationRecord
  include Discard::Model
  belongs_to :breed
  belongs_to :category

  has_many_attached :pet_images

  enum gender: { male: 1, female: 2, unknown: 0 }
  enum status: { available: 0, unavailable: 1 }

  validates :category_id, :breed_id, :age, :gender, :temperament, :status, presence: true
  validates :vaccination_status, inclusion: { in: [ true, false ] }

  # Method to return multiple image URLs
  def pet_images_urls
    pet_images.map { |image| Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) }
  end

  # Fetch category name
  def category_name
    category&.category_name || "Unknown Category"
  end

  # Fetch breed name
  def breed_name
    breed&.breed_name || "Unknown Breed"
  end
end
