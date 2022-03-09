class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  # Home page
  def home
    @meals = Meal.all
  end

  # Search results with map page
  def index

  end

  # Specific meal page
  def show
    @meal = Meal.find(params[:id])
    @order = Order.find(params[:id])
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user


    if @meal.save!
      redirect_to meals_path
    else
      render :new
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :cuisine, :price, :available_quantity, :available_quantity, :collection_from, :collection_to, photos: [])
  end

  def order_params
    params.require(:order).permit(:user_id, :is_paid, :is_picked_up)
  end
end
