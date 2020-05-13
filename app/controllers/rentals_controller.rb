class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @customer = Customer.all
    @car_category = CarCategory.all
  end

  def create
    @rental = Rental.create(rental_params)

    RentalsMailer.scheduled(@rental).deliver_now
    
    redirect_to @rental
  end

  def search
    @q = params[:q]
    @rental = Rental.find_by(code: @q.upcase)
    #if @rental.blank? || params[:q].blank?
    #  @rentals = Rental.all
    #  flash.now[:alert] = "Nenhum resultado encontrado para: #{@q}"
    #  render :index
    #end
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, 
                                    :customer_id, :car_category_id)
  end
end
