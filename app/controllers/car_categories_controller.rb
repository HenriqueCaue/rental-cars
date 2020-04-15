class CarCategoriesController < ApplicationController
  def index
    @carcategories = CarCategory.all
  end

  def show
    @carcategories = CarCategory.find(params[:id])
  end
end

