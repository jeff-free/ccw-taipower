class CreateRelatives < ActiveRecord::Migration[5.2]
  def change
    create_table :relatives do |t|
      t.string :name
      t.string :title
      t.integer :representative_id
      t.integer :kinship
      t.boolean :mismatch, default: false

      t.timestamps
    end
    add_index :relatives, :representative_id
    add_index :relatives, :kinship
  end
end
