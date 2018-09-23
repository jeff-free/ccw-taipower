class PagesController < ApplicationController
  def index
    @representatives = Representative.includes(:relatives,
                                               :expenditures,
                                               relatives: [
                                                 :expenditures,
                                               {
                                                 organization: :expenditures
                                               }
                                             ]
                                             ).joins(:expenditures).distinct
  end
end
