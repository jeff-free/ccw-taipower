class Expenditure < ApplicationRecord
  include Importable
  validates_presence_of :title, :amount, :approved_date

  def self.import(file)
    return false unless file
    xlsx = Roo::Spreadsheet.open(file)
    xlsx_valid_sheets_ary = xlsx.sheets.delete_if do |sheet_name|
      sheet_name.match('總表').blank?
    end
    xlsx_valid_sheets_ary.each do |sheet_name|
      sheet = xlsx.sheet(sheet_name)
      transaction do
        (2..sheet.last_row).each do |row_number|
          row = sheet.row(row_number)
          Expenditure.where(
            title: row[4],
            approved_date: row[5],
            amount: row[10],
            organization_name: row[2]
          ).first_or_create
        end
      end
    end
  end
end
