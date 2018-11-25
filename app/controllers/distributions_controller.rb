class DistributionsController < ApplicationController
  def index
    @expenditures = Expenditure.all
    if params[:city]
      @expenditures_of_city = @expenditures.where(city: params[:city]).page(params[:page]).per(25)
    end
  end

  def show
    
  end
end
