class CreateBuyers < ActiveRecord::Migration[8.1]
  def change
    create_table :buyers do |t|
      t.string :name
      t.string :email
      t.string :country

      t.timestamps
    end
  end
end
