class Sample < ApplicationRecord
  belongs_to :style

  #status constants

  STATUSES = %w[
    pending
    submitted
    approved
    rejected
    revised
    resubmitted
  ].freeze

  validates :status, inclusion: {in: STATUSES}

  #status check methods
  def pending?
    status == "pending"
  end
  
  def approved?
    status == "approved"
  end

  def rejected?
    status == "rejected"
  end


end
