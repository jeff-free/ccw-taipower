class Admin::ReportsController < Admin::BaseController
  def index
    @report = ReportBuilder.new
    respond_to do |format|
      format.csv { send_data @report.to_csv }
    end
  end
end
