class User < ApplicationRecord
  has_secure_password

  ROLES = %w[admin merchandiser factory buyer].freeze

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :role, inclusion: { in: ROLES }
end