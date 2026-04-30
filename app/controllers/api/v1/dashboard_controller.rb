class Api::V1::DashboardController < ApplicationController
    before_action :authenticate_user!
  def index
    render json: {
      summary: {
        total_buyers: Buyer.count,
        total_styles: Style.count,
        total_samples: Sample.count,
        total_bulk_orders: BulkOrder.count
      },
      samples: {
        pending: Sample.where(status: "pending").count,
        approved: Sample.where(status: "approved").count,
        rejected: Sample.where(status: "rejected").count
      },
      bulk_orders: {
        not_started: BulkOrder.where(production_status: "not_started").count,
        in_progress: BulkOrder.where(production_status: "in_progress").count,
        completed: BulkOrder.where(production_status: "completed").count,
        delayed: BulkOrder.where(production_status: "delayed").count,
        shipped: BulkOrder.where(production_status: "shipped").count
      },
      buyers_summary: Buyer.all.map do |buyer|
        {
          buyer: buyer.name,
          country: buyer.country,
          total_styles: buyer.styles.count,
          total_samples: buyer.samples.count,
          total_bulk_orders: buyer.bulk_orders.count,
          delayed_orders: buyer.bulk_orders.where(production_status: "delayed").count,
          total_quantity: buyer.bulk_orders.group(:quantity_unit).sum(:quantity)
        }
      end
    }
  end
end