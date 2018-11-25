class AddSourceIndexNoToExpenditures < ActiveRecord::Migration[5.2]
  def change
    add_column :expenditures, :source_index_no, :integer
    add_index :expenditures, :source_index_no
  end
end
