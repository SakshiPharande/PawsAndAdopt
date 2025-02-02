class Admin::UsersController < ApplicationController
  def index
    @users = User.kept.where(role: "user")
  end

  def show
  @user = User.find(params[:id])
  end

  def discard
    @user = User.find(params[:id])  # Find the user
    if @user.discard  # Soft delete the user
      flash[:notice] = "User has been discarded (soft deleted)."
    else
      flash[:alert] = "Failed to discard user."
    end
    redirect_to admin_users_path
  end


private

def user_params
params.require(:user).permit(:first_name, :last_name, :email, :phone_no, :password, :role)
end
end
