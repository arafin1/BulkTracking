class Buyer < ApplicationRecord
    
  has_many :styles
  has_many :samples, through: :styles
  has_many :bulk_orders, through: :samples

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

end
