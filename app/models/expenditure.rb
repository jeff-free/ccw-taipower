class Expenditure < ApplicationRecord
  include Importable
  belongs_to :organization, required: false
  has_one :relative, through: :organization, source: :owner
  has_one :representative, through: :relative
  validates_presence_of :title, :amount, :approved_date

  def self.import(file)
    return false unless file

    xlsx = Roo::Spreadsheet.open(file)
    xlsx_valid_sheets_ary = xlsx.sheets.delete_if do |sheet_name|
      sheet_name.match('總表').blank?
    end
    xlsx_valid_sheets_ary.each do |sheet_name|
      sheet = xlsx.sheet(sheet_name).drop(1)
      transaction do
        sheet.each do |row|
          next unless row[5].is_a?(Date)
          location = row[1] || '其他'
          expense = Expenditure.find_or_initialize_by(
            title: row[4],
            approved_date: row[5].try(:in_time_zone),
            amount: row[10],
            organization_name: row[2],
            source_index_no: row[0]
          )
          expense.assign_attributes(city: location.first(3),
                                    district: location[3..6])
          expense.save
        end
      end
    end
  end
end
