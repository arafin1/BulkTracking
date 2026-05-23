class AddLockVersionToSamples < ActiveRecord::Migration[8.1]
  def change
    add_column :samples, :lock_version, :integer
  end
end
