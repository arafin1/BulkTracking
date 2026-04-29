class Style < ApplicationRecord

  belongs_to :buyer
  has_many :samples
  has_many :bulk_orders, through: :samples

  validates :style_number, presence: true, uniqueness: true
end
