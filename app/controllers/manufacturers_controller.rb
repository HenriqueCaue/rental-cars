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

  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update(manufacturer_params)
      redirect_to @manufacturer
    else
      render :new
    end
  end

  def destroy
    @manufacturer = Manufacturer.find(params[:id])
    @manufacturer.destroy
    redirect_to manufacturers_path
  end
  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end
end