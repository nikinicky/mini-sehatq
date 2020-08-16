class Order < ApplicationRecord
  belongs_to :appointment

  PENDING = 'pending'.freeze
  PAID = 'paid'.freeze
  COMPLETED = 'completed'.freeze

  PAID_STATUSES = [self::PAID, self::COMPLETED]
end
