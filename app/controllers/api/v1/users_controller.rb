class Api::V1::UsersController < Api::V1::BaseController
   # GET /api/v1/users/profile
   def show
    render json: @current_user, status: :ok
   end

  # PUT /api/v1/users/profile
  def update
    if @current_user.update(user_params)
      render json: @current_user, status: :ok
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_no, :password)
  end
end
