class RemoveRelativesMismatch < ActiveRecord::Migration[5.2]
  def change
    remove_column :relatives, :mismatch, :boolean, default: false, index: true
  end
end
