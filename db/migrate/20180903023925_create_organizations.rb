class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :representative_id
      t.integer :np_type

      t.timestamps
    end
    add_index :organizations, :representative_id
    add_index :organizations, :np_type
  end
end
