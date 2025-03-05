require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    subject { create(:user) }  # Ensures an existing record
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe "Associations" do
    it { should have_one_attached(:profile_image) }
  end

  describe "Enums" do
    it { should define_enum_for(:role).with_values(user: 0, admin: 1) }
  end

  describe "#profile_image_url" do
    let(:user) { create(:user) }

    context "when profile image is attached" do
      before do
        user.profile_image.attach(
          io: StringIO.new("fake image data"),
          filename: "test-image.jpg",
          content_type: "image/jpeg"
        )
      end

      it "returns the URL of the attached image" do
        expect(user.profile_image_url).to include("/rails/active_storage/blobs/")
      end
    end

    context "when profile image is NOT attached" do
      it "returns default image path for user role" do
        expect(user.profile_image_url).to include("default-user-profile-pic")
      end

      it "returns default image path for admin role" do
        admin = create(:user, role: :admin)
        expect(admin.profile_image_url).to include("default-admin-profile-pic")
      end
    end
  end
end
