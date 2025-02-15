class Admin::DonatePetsController < ApplicationController
  before_action :set_donate_pet, only: [ :update ] # Ensure this is called before update

  def index
    @donate_pets = DonatePet.includes(user: {}, pet: { breed: :category }).all
  end

  def show
    @donate_pet = DonatePet.includes(user: {}, pet: { breed: :category }).find(params[:id])
  end

  def update
    @donate_pet = DonatePet.find(params[:id])

    update_success = false

    if params[:status].present? && DonatePet.statuses.keys.include?(params[:status])
      update_success = @donate_pet.update(status: params[:status])
    elsif params[:donate_pet].present? && params[:donate_pet][:actual_donate_date].present?
      update_success = @donate_pet.update(actual_donate_date: params[:donate_pet][:actual_donate_date])
    end

    respond_to do |format|
      if update_success
        format.html { redirect_to admin_donate_pets_path, notice: "Donation request updated successfully." }
        format.turbo_stream
      else
        format.html { redirect_to admin_donate_pets_path, alert: "Failed to update donation request." }
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
