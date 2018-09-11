class CreateRepresentatives < ActiveRecord::Migration[5.2]
  def change
    create_table :representatives do |t|
      t.string :name
      t.integer :party
      t.integer :job_type
      t.string :job_title

      t.timestamps
    end
    add_index :representatives, :party
    add_index :representatives, :job_type
  end
end
