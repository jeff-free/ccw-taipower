class DistributionsController < ApplicationController
  def index
    @expenditures = Expenditure.all
  end

  def show
    
  end
end
