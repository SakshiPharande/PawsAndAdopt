class Admin::AdoptPetsController < ApplicationController
  def index
    @adopt_pets = AdoptPet.includes(user: {}, pet: { breed: :category }).all
  end

  def show
    @adopt_pet = AdoptPet.includes(user: {}, pet: { breed: :category }).find(params[:id])
  end

  def update
    @adopt_pet = AdoptPet.find(params[:id])

    if params[:status].present? && AdoptPet.statuses.keys.include?(params[:status])
      @adopt_pet.update(status: params[:status])

      respond_to do |format|
        format.html { redirect_to admin_adopt_pets_path, notice: "Adopt request has been #{params[:status]} successfully." }
        format.turbo_stream
      end
    else
      flash[:error] = "Invalid status update."
      redirect_to admin_adopt_pets_path
    end
  end


  private

  def set_adopt_pet
    @adopt_pet = AdoptPet.find_by(id: params[:id])
    unless @adopt_pet
      flash[:error] = "Adoption request not found."
      redirect_to admin_adopt_pets_path
    end
  end
end
