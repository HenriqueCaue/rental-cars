class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rentals = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @customer = Customer.all
    @car_category = CarCategory.all
  end

  def create
    @rental = Rental.create(rental_params)
    redirect_to @rental
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, 
                                    :customer_id, :car_category_id)
  end
end
