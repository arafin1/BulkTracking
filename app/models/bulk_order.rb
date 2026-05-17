class BulkOrder < ApplicationRecord
  belongs_to :sample

  PRODUCTION_STATUSES = %w[
    not_started
    in_progress
    completed
    delayed
    shipped
  ].freeze

  QUANTITY_UNITS = %w[
    pcs
    yds
    meters
    kg
    dozens
    sets
  ].freeze

  validates :quantity_unit, inclusion: { in: QUANTITY_UNITS }
  validates :production_status, inclusion: { in: PRODUCTION_STATUSES }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  
  # ❌ REMOVED: validates :status, presence: true

  def in_progress?
    production_status == "in_progress"
  end

  def completed?
    production_status == "completed"
  end

  def delayed?
    production_status == "delayed"
  end
end