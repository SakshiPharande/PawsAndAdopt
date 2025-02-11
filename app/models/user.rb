class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Discard::Model
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true
  enum role: { user: 0, admin: 1, super_admin: 2 }

  # Attach profile image using Active Storage
  has_one_attached :profile_image

  # Method to return profile image URL (with default)
  def profile_image_url
    if profile_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(profile_image, only_path: true)
    else
      default_image =
        case role
        when "superadmin"
          "default-super-admin-profile-pic.png"
        when "admin"
          "default-admin-profile-pic.jpg"
        else
          "default-user-profile-pic.png"
        end

      ActionController::Base.helpers.asset_path(default_image)
    end
  end
end
