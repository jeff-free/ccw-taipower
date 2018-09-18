class AddExpendituresOrganizationName < ActiveRecord::Migration[5.2]
  def change
    add_column :expenditures, :organization_name, :string, index: true
  end
end
