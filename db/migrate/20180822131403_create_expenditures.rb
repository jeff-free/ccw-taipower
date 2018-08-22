class CreateExpenditures < ActiveRecord::Migration[5.2]
  def change
    create_table :expenditures do |t|
      t.string :title
      t.integer :amount
      t.integer :applicant_id

      t.timestamps
    end
  end
end
