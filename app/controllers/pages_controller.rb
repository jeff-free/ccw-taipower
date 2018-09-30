class PagesController < ApplicationController
  def index
    @representatives =
      Representative.joins(:expenditures)
                    .includes(:expenditures,
                              relatives: [
                                :organization,
                                :expenditures
                              ]).distinct
  end

  def about; end

  def knowledge; end
end
