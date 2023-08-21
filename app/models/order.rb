class Order < ApplicationRecord
  belongs_to :merchant
  has_many :orders_disbursements
  has_many :disbursements, through: :orders_disbursements

  scope :on_date, -> (date) {
    where(created_at: date)
  }
  scope :disbursed, -> { where(disbursed: true) }
  scope :undisbursed, -> { where(disbursed: false) }
  scope :last_week, -> (date) {
    where('created_at BETWEEN :from_date AND :to_date', from_date: date - 7, to_date: date.yesterday)
  }

  def commission_amount
    case amount
    when 0.0..50.0
      (amount / 100.0).round(2)
    when 50.0..300.00
      (amount / 100 * 0.95).round(2)
    when 300..(1.0 / 0.0)
      (amount / 100.0 * 0.85).round(2)
    else
      0.0
    end
  end
end
