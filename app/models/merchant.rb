# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :orders
  has_many :orders_disbursements, through: :orders
  has_many :disbursements, -> (merchant) {
    unscope(where: :merchant_id).
    where(id: merchant.orders_disbursements.pluck(:disbursement_id).uniq)
  }

  enum disbursement_frequency: {
    DAILY: 0,
    WEEKLY: 1
  }
end
