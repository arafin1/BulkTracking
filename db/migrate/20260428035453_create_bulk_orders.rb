class CreateBulkOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :bulk_orders do |t|
      t.references :sample, null: false, foreign_key: true
      t.integer :quantity
      t.date :delivery_date
      t.string :production_status
      t.text :factory_notes

      t.timestamps
    end
  end
end
