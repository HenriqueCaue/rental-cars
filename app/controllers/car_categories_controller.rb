class CarCategoriesController < ApplicationController
  def index
    @carcategories = CarCategory.all
  end

  def show
    @carcategories = CarCategory.find(params[:id])
    #@car_models = CarModel.where(car_category: @carcategories)
  end

  def new
    @carcategory = CarCategory.new
  end

  def create 
    @carcategory = CarCategory.new(carcategory_params)
    if @carcategory.save
      redirect_to @carcategory
    else 
      render :new
    end
  end

  def edit
    @carcategory = CarCategory.find(params[:id])
  end

  def update
    @carcategory = CarCategory.find(params[:id])
    if @carcategory.update(carcategory_params)
      redirect_to @carcategory
    else
      render :new
    end
  end
  private

  def carcategory_params
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_part_insurance)
  end
end

