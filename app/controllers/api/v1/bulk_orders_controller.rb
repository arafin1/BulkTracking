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
    
    # Check your instance variable context from your ApplicationController hook safely
    if @current_user&.role == 'admin' || @current_user&.role == 'production_manager'
      
      # 1. 💡 Update using the true database column name (:production_status)
      if @bulk_order.update(production_status: update_status_params[:status])
        
        # 2. 💡 CRITICAL FIX: Customizing the rendered JSON response object.
        # If your ActiveModel Serializer attempts to include a missing 'status' field, 
        # rendering the raw @bulk_order object directly can crash the server here.
        render json: {
          id: @bulk_order.id,
          sample_id: @bulk_order.sample_id,
          quantity: @bulk_order.quantity,
          production_status: @bulk_order.production_status,
          status: @bulk_order.production_status # Send 'status' to keep React frontend stable!
        }, status: :ok

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

  # 3. 💡 Captures the 'status' key coming out of your React payload seamlessly
  def update_status_params
    params.require(:bulk_order).permit(:status)
  end
end