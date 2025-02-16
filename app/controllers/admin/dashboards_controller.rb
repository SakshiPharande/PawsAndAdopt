class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!  # Ensures user is logged in
  before_action :ensure_admin  # Ensures user is an admin

  def index
    @user_count = User.kept.where(role: "user").count
    @category_count = Category.kept.count
    @breed_count = Breed.kept.count
    @pet_count = Pet.kept.count
  end

  # Check if the current user is an admin
  def ensure_admin
    unless current_user.admin? || current_user.super_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
