class RelativesController < ApplicationController
  def index
    @representatives = Representative.all.group_by(&:party)
  end
end
