class Expenditure < ApplicationRecord
  attr_accessor :file

  def self.import(file)
    return false unless file
    sheet =  Roo::Spreadsheet.open(file)
  end
end
