class AddMismatchToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :mismatch, :boolean, default: false
    add_index :organizations, :mismatch
    Organization.joins(:owner).includes(:owner)
                .where(relatives: { mismatch: true })
                .in_batches do |organizations|
                  organizations.update_all(mismatch: true)
                end
  end
end
