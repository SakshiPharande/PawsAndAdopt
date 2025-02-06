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
      load_categories_and_breeds
      flash.now[:alert] = @pet.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @pet = Pet.find(params[:id])
    load_categories_and_breeds
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      redirect_to admin_pets_path, notice: "Pet successfully updated."
    else
      load_categories_and_breeds
      flash.now[:alert] = @pet.errors.full_messages.to_sentence
      render :edit
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
                                :status, :breed_id, :category_id).tap do |pet_params|
      pet_params[:gender] = pet_params[:gender].to_i if pet_params[:gender].present?
      pet_params[:status] = pet_params[:status].to_i if pet_params[:status].present?
    end
  end
end
