class CreateRepresentatives < ActiveRecord::Migration[5.2]
  def change
    create_table :representatives do |t|
      t.string :name
      t.integer :party

      t.timestamps
    end
    add_index :representatives, :party
  end
end
