class Admin::DonatePetsController < ApplicationController
  before_action :set_donate_pet, only: [ :update ] # Ensure this is called before update

  def index
    @donate_pets = DonatePet.includes(user: {}, pet: { breed: :category }).all
  end

  def show
    @donate_pet = DonatePet.includes(user: {}, pet: { breed: :category }).find(params[:id])
  end

  def update
    @donate_pet = DonatePet.find(params[:id]) # Ensure @donate_pet is set

    if params[:status].present? && DonatePet.statuses.keys.include?(params[:status])
      @donate_pet.update(status: params[:status])

      respond_to do |format|
        format.html { redirect_to admin_donate_pets_path, notice: "Donation request has been #{params[:status]} successfully." }
        format.turbo_stream # This will trigger `update.turbo_stream.erb`
      end
    else
      flash[:error] = "Invalid status update."
      redirect_to admin_donate_pets_path
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
