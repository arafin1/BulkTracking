class AddStatusToBulkOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :bulk_orders, :status, :string
  end
end
