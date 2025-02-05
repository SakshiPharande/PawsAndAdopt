class Admin::PetsController < ApplicationController
  def index
    @pets = Pet.kept.includes(:category, :breed)
  end

  def show
    @pet = Pet.includes(:category, :breed).find_by(id: params[:id])
  end

  def new
    @pet = Pet.new
    load_categories_and_breeds
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      redirect_to admin_pets_path, notice: "Pet successfully added."
    else
      load_categories
      load_breeds
      flash.now[:alert] = @pet.errors.full_messages.to_sentence
      Rails.logger.debug @pet.errors.full_messages # Log errors for debugging
      render :new
    end
  end



  def discard
    @pet = Pet.find(params[:id])
    if @pet.discard
      flash[:notice] = "pet has been deleted (soft deleted)."
    else
      flash[:alert] = "Failed to delete pet."
    end
    redirect_to admin_pets_path
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def load_categories_and_breeds
    @categories = Category.kept
    @breeds = Breed.kept
  end

  def pet_params
    params.require(:pet).permit(:age, :gender, :temperament, :vaccination_status,
                                :medical_history, :recommended_food, :common_health_issues,
                                :status, :breed_id, :category_id)
  end
end
