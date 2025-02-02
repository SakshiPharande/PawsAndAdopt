class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.kept
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "Category added successfully."
    else
      render :new, alert: "Error: Category could not be added."
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Category updated successfully."
    else
      render :edit, alert: "There was an issue updating the category."
    end
  end

  def discard
    @category = Category.find(params[:id])
    if @category.discard  # Soft delete the user
      flash[:notice] = "Category has been deleted (soft deleted)."
    else
      flash[:alert] = "Failed to delete user."
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end
end
