class AddQuantityUnitToBulkOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :bulk_orders, :quantity_unit, :string
  end
end
