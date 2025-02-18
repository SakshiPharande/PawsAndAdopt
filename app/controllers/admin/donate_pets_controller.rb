class Admin::DonatePetsController < ApplicationController
  before_action :set_donate_pet, only: [ :update ] # Ensure this is called before update

  def index
    @donate_pets = DonatePet.includes(user: {}, pet: { breed: :category }).all.paginate(page: params[:page], per_page: 5)
  end

  def show
    @donate_pet = DonatePet.includes(user: {}, pet: { breed: :category }).find(params[:id])
  end

  def update
    @donate_pet = DonatePet.find(params[:id])
    @donate_pet_index = params[:index].to_i if params[:index].present?
    update_success = false

    if params[:status].present? && DonatePet.statuses.keys.include?(params[:status])
      update_success = @donate_pet.update(status: params[:status])
    elsif params[:donate_pet].present? && params[:donate_pet][:actual_donate_date].present?
      update_success = @donate_pet.update(actual_donate_date: params[:donate_pet][:actual_donate_date])
    end

    respond_to do |format|
      if update_success
        # Ensure Turbo Stream is used to replace the row correctly
        format.html { redirect_to admin_donate_pets_path, notice: "Donation request updated successfully." }
        format.turbo_stream
      else
        format.html { redirect_to admin_donate_pets_path, alert: "Failed to update donation request." }

        format.turbo_stream do
          # Ensure Turbo Stream replaces the correct row using its ID
          render turbo_stream: turbo_stream.replace("donate_pet_#{@donate_pet.id}",
            partial: "admin/donate_pets/donate_pet", formats: :html,
            locals: { donate_pet: @donate_pet, index: @donate_pet_index }
          )
        end
      end
    end
  end




  private

  def set_donate_pet
    @donate_pet = DonatePet.find_by(id: params[:id]) # Use find_by to avoid exception
    unless @donate_pet
      flash[:error] = "Donation request not found."
      redirect_to admin_donate_pets_path
    end
  end
end
