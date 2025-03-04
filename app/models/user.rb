class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Discard::Model
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true
  enum role: { user: 0, admin: 1 }

    # Attach profile image using Active Storage
    has_one_attached :profile_image
    has_many :pets
    has_many :donate_pets
    has_many :adopt_pets


  # Method to return profile image URL (with default)
  def profile_image_url
    if profile_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(profile_image, only_path: false)
    else
      default_image =
        case role
        when "admin"
          "default-admin-profile-pic.jpg"
        else
          "default-user-profile-pic.png"
        end

      ActionController::Base.helpers.asset_path(default_image)
    end
  end
end
