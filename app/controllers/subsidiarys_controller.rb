class SubsidiarysController < ApplicationController
  def index
    @subsidiarys = Subsidiary.all
  end

  def show
    id = params[:id]
    @subsidiary = Subsidiary.find(id)
  end
end