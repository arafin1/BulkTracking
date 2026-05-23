class Api::V1::SamplesController < ApplicationController
  before_action :authenticate_user!

  def index
    samples = Sample.all
    render json: samples
  end

  def create
    sample = Sample.new(sample_params)
    if sample.save
      render json: sample, status: :created
    else
      render json: sample.errors, status: :unprocessable_entity
    end
  end

  def update
    sample = Sample.find(params[:id])
    if sample.update(sample_params)
      render json: sample
    else
      render json: sample.errors, status: :unprocessable_entity
    end
  end

  def update_status
    sample = Sample.find(params[:id])

    status = params[:status] ||
             params.dig(:sample, :status)

    unless allowed_to_update?(status)
      render json: {
        error: "You don't have permission to set this status"
      }, status: :forbidden
      return
    end

    if sample.update_column(:status, status)
      render json: sample
    else
      render json: { error: "Failed to update status" },
             status: :unprocessable_entity
    end
  end

  private

  def allowed_to_update?(status)
    role = @current_user.role

    merchandiser_statuses = %w[pending submitted revised resubmitted]
    buyer_statuses = %w[approved rejected]
    admin_statuses = Sample::STATUSES

    case role
    when "admin"
      admin_statuses.include?(status)
    when "merchandiser"
      merchandiser_statuses.include?(status)
    when "buyer"
      buyer_statuses.include?(status)
    when "factory"
      false
    else
      false
    end
  end

  def sample_params
    params.require(:sample).permit(
      :style_id,
      :sample_type,
      :date_sent,
      :status,
      :buyer_comments
    )
  end
end