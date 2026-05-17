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
    @bulk_order = BulkOrder.find(params[:id])
    
    # Using @current_user safely based on your ApplicationController setup
    if @current_user&.role == 'admin' || @current_user&.role == 'production_manager'
      
      # 💡 FIX: Safely map and update the actual database column (:production_status)
      if @bulk_order.update(production_status: update_status_params[:status])
        render json: @bulk_order, status: :ok
      else
        render json: { error: @bulk_order.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Insufficient factory line administrative clearance." }, status: :unauthorized
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

  # 💡 FIX: Permit the incoming key ':status' coming from the React client payload
  def update_status_params
    params.require(:bulk_order).permit(:status)
end
end