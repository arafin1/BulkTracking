class AddUniqueIndexToBuyers < ActiveRecord::Migration[8.1]
  def change
    add_index :buyers, :email, unique: true
  end
end
