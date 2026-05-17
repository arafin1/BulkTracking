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
            render json: {error: "Sample must be approved first"}, status: :unprocessable_entity
        end
    end

    def update_status
        @bulk_order = BulkOrder.find(params[:id])
        
        # 🛡️ Map "production_status" to your column if they are named differently:
        status_to_update = params[:bulk_order][:production_status] || params[:bulk_order][:status]

        # Use attributes mapping directly
        if @bulk_order.update(status: status_to_update) # Change :status to match your database column name
          render json: { message: "Status updated successfully", bulk_order: @bulk_order }, status: :ok
        else
          # 💡 This will return the exact validation error (e.g., "Quantity unit is not included in the list")
          render json: { error: @bulk_order.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
      end
    private 

   private

    def bulk_order_params
        params.require(:bulk_order).permit(:sample_id, :quantity, :quantity_unit, :production_status, :status)
    end
end