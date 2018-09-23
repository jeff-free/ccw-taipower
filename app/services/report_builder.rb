require 'csv'

class ReportBuilder
  attr_reader :expenditures, :rows
  def initialize
    @expenditures = Expenditure.joins(:organization)
                               .merge(Organization.joins(:owner))
                               .merge(Relative.where.not(mismatch: true))
    @rows = @expenditures.map do |exp|
      [exp.representative.job_title, exp.representative.name,
       exp.representative.party, exp.relative.kinship_name,
       exp.relative.name, exp.organization.name, exp.amount,
       exp.approved_date]
    end
  end

  def to_csv
    CSV.generate do |csv|
      csv << %w(職稱 民代姓名 黨籍 親屬關係 親屬姓名 負責團體 金額 核准日期)
      rows.each do |row|
        csv << row
      end
    end
   end
end
