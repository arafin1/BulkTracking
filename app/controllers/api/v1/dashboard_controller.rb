class Api::V1::DashboardController < ApplicationController
    def index
        render json:{
            samples:{
                total: Sample.count,
                pending: Sample.where(status: "pending").count,
                submitted: Sample.where(status:"submitted").count,
                approved: Sample.where(status:"approved").count,
                rejected: Sample.where(status:"rejected").count,
                revised: Sample.where(status: "revised").count 
            },
            bulk_orders: {
                total: BulkOrder.count,
                not_started: BulkOrder.where(production_status:"not_started").count,
                in_progress: BulkOrder.where(production_status:"in_progress").count,
                completed: BulkOrder.where(production_status: "completed").count,
                delayed: BulkOrder.where(production_status:"delayed").count,
                shipped: BulkOrder.where(production_status: "shipped").count
            },
            buyers:{
                total: Buyer.count
            },
            styles:{
                total:Style.count
            }
        }
    end
end
