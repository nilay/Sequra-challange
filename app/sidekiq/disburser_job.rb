# frozen_string_literal: true

# background job to generate Disbursement for all merchants
class DisburserJob
  include Sidekiq::Job

  def perform(*args)
    Merchant.all.each do |merchant|
      DisbursementService.new(merchant, Date.today).call
    end
  end
end
