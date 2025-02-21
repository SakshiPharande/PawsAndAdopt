class Admin::AdminsController < ApplicationController
  def show
    @admin = current_user
    unless @admin.admin?
      redirect_to root_path, alert: "You are not authorized to view this page."
    end
  end

  def edit
    @admin = User.find(params[:id]).where(role: "admin")
  end

  def update
    @admin = User.find(params[:id]).where(role: "admin")
    # Remove images if any are marked for deletion
    if params[:pet][:removed_images].present?
      params[:pet][:removed_images].each do |image_id|
        @pet.pet_images.find(image_id).purge
      end
    end

    if @pet.update(pet_params)
      redirect_to admin_admins_path, notice: "Profile updated successfully!"
    else
      render :edit
    end
  end
end
