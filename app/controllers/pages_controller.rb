class PagesController < ApplicationController
  def index
    @representatives =
      Representative.joins(:expenditures).distinct
  end

  def about; end

  def knowledge; end
end
