class Admin::ReportsController < Admin::BaseController
  def index
    @report = ReportBuilder.new
    respond_to do |format|
      format.xlsx
    end
  end
end
