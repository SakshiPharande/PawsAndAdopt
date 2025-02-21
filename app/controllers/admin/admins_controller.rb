class Admin::AdminsController < ApplicationController
  before_action :authorize_admin # Ensure only admins can edit their profiles

  def show
    @admin = current_user
  end

  def edit
    @admin = current_user
  end

  def update
    @admin = current_user

    if @admin.update(admin_params)
      # Handle profile image update
      if params[:user][:profile_image].present?
        @admin.profile_image.purge # Remove existing profile image before uploading a new one
        @admin.profile_image.attach(params[:user][:profile_image])
      end

      redirect_to admin_admins_path, notice: "Profile updated successfully!"
    else
      render :edit
    end
  end

  private

  def admin_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_no, :profile_image)
  end

  def authorize_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
