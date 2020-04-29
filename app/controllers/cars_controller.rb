class CarsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
    @car_model = CarModel.all
    @subsidiary = Subsidiary.all
  end

  def create
    @car = Car.create(car_params)
    redirect_to @car
  end

  private

  def car_params
    params.require(:car).permit(:car_model_id, :license_plate, :color,
       :mileage, :subsidiary_id)
  end
end
