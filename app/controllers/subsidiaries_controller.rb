class SubsidiariesController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    id = params[:id]
    @subsidiary = Subsidiary.find(id)
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new
    @subsidiary.name = params[:subsidiary][:name]
    @subsidiary.cnpj = params[:subsidiary][:cnpj]
    @subsidiary.address = params[:subsidiary][:address]
    @subsidiary.save
    redirect_to @subsidiary
  end
end