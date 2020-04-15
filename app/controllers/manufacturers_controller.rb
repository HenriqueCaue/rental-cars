class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
  end

  def show
    id = params[:id]
    @manufacturer = Manufacturer.find(id)
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    #@manufacturer = Manufacturer.new(params.require(:manufacturer).permit(:name))
    #@manufacturer = Manufacturer.new(name: params[manufacturer][:name])
    #@manufacturer = Manufacturer.create(name: params[manufacturer][:name])
    @manufacturer = Manufacturer.new(manufacturer_params)
    #@manufacturer.name = params[:manufacturer][:name]
    if @manufacturer.save
      flash[:notice] = 'Fabricante criada com sucesso'
      redirect_to @manufacturer
    else 
      render :new
    end
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end