class Admin::PetsController < ApplicationController
  helper_method :load_categories, :load_breeds

  def index
    @pets = Pet.kept.includes(:category, :breed)
  end
end

def show
  @pet = Pet.find(params[:id])
end

def new
  @pet = Pet.new
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

def load_categories
  Category.kept
end

def load_breeds
  Breed.kept
end

def pet_params
  params.require(:pet).permit(:age, :gender, :temperament, :vaccination_status,
                              :medical_history, :recommended_food, :common_health_issues,
                              :status, :breed_id, :category_id)
end
