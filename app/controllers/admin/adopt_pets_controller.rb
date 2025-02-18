class Admin::AdoptPetsController < ApplicationController
  def index
    @adopt_pets = AdoptPet.includes(user: {}, pet: { breed: :category }).all.paginate(page: params[:page], per_page: 5)
  end

  def show
    @adopt_pet = AdoptPet.includes(user: {}, pet: { breed: :category }).find(params[:id])
  end

  def update
    @adopt_pet = AdoptPet.find(params[:id])  # Ensure @adopt_pet is set
    @adopt_pet_index = params[:index].to_i if params[:index].present?

    if params[:adopt_pet]
      update_adopt_pet_date
    elsif params[:status].present? && AdoptPet.statuses.keys.include?(params[:status])
      update_adopt_pet_status
    else
      flash[:error] = "Invalid update request."
      redirect_to admin_adopt_pets_path
    end
  end

  private


  # Method to update actual adoption date
  def update_adopt_pet_date
    if @adopt_pet.update(adopt_pet_params)
      @index = @adopt_pet.id
      respond_to do |format|
        format.html { redirect_to admin_adopt_pets_path, notice: "Adoption date updated successfully." }
        format.turbo_stream
      end
    else
      flash[:error] = "Failed to update adoption date."
      redirect_to admin_adopt_pets_path
    end
  end

  # Method to update pet status
  def update_adopt_pet_status
    if @adopt_pet.update(status: params[:status])
      @index = @adopt_pet.id
      respond_to do |format|
        format.html { redirect_to admin_adopt_pets_path, notice: "Adopt request has been #{params[:status]} successfully." }
        format.turbo_stream
      end
    else
      flash[:error] = "Status update failed."
      redirect_to admin_adopt_pets_path
    end
  end

  def set_adopt_pet
    @adopt_pet = AdoptPet.find_by(id: params[:id])
    unless @adopt_pet
      flash[:error] = "Adoption request not found."
      redirect_to admin_adopt_pets_path
    end
  end

  def adopt_pet_params
    params.require(:adopt_pet).permit(:actual_adoption_date, :status)
  end
end
