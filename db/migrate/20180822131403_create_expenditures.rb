class CreateExpenditures < ActiveRecord::Migration[5.2]
  def change
    create_table :expenditures do |t|
      t.string :title
      t.integer :amount
      t.integer :organization_id, index: true
      t.datetime :approved_date, index: true

      t.timestamps
    end
  end
end
