class Api::V1::BulkOrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    bulk_orders = BulkOrder.all 
    render json: bulk_orders
  end

  def create
    sample = Sample.find(params[:bulk_order][:sample_id])
    if sample.approved?
      bulk_order = BulkOrder.new(bulk_order_params)
      if bulk_order.save
        render json: bulk_order, status: :created
      else
        render json: bulk_order.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Sample must be approved first" }, status: :unprocessable_entity
    end
  end
def update_status
  bulk_order = BulkOrder.find(params[:id])

  status = params[:production_status] ||
           params.dig(:bulk_order, :production_status)

  if bulk_order.update_column(:production_status, status)
    render json: bulk_order
  else
    render json: { error: "Failed to update status" },
           status: :unprocessable_entity
  end
end

  private 

  def bulk_order_params
    params.require(:bulk_order).permit(
      :sample_id,
      :quantity,
      :quantity_unit,
      :delivery_date,
      :production_status,
      :factory_notes
    )
  end

  # 3. 💡 Captures the 'status' key coming out of your React payload seamlessly
  def update_status_params
    params.require(:bulk_order).permit(:status)
  end
end