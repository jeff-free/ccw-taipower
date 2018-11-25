class AddCityDistrictToExpenditures < ActiveRecord::Migration[5.2]
  def change
    add_column :expenditures, :city, :string
    add_index :expenditures, :city
    add_column :expenditures, :district, :string
    add_index :expenditures, :district
  end
end
