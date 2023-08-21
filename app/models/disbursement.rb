# frozen_string_literal: true

class Disbursement < ApplicationRecord

  before_create :set_reference_number
  has_many :orders_disbursements
  has_many :orders, through: :orders_disbursements

  scope :by_month, -> (month, year) {
    where(
      "EXTRACT('year' FROM disbursement_date) = :year
      AND EXTRACT('month' FROM disbursement_date) = :month",
      { month:, year: }
    )
  }


  def self.report
    Disbursement.select("
      EXTRACT('year' FROM disbursement_date) as year,
      COUNT(disbursement_date) as disbursed_count,
      SUM(amount) as disbursed_amount_total,
      SUM(fee) as order_fee,
      SUM(left_over_fee) as monthly_fee_charge_amount,
      COUNT(left_over_fee) AS monthly_fee_charged_count").group(:year)
  end

  private

  def set_reference_number
    self.reference_number = SecureRandom.uuid
  end
end
