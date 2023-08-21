# frozen_string_literal: true

class DisbursementService
  def initialize(merchant, date)
    @merchant = merchant
    @date = date
  end

  def call
    @merchant.DAILY? ? daily_generator : weekly_generator
  end

  private

  # generate disbursement of all orders happened on previous day of given date
  def daily_generator
    create_disbursement(@merchant.orders.on_date(@date.yesterday).undisbursed)
  end

  def weekly_generator
    return unless @merchant.live_on.wday == @date.wday

    create_disbursement(@merchant.orders.last_week(@date).undisbursed)
  end

  # sum of fee charges during last month
  def last_month_fee
    previous_month = @date - 1.month
    @merchant.disbursements.by_month(
      previous_month.month,
      previous_month.year
    ).sum(:fee)
  end

  # Checks if disbursement is the first of the month
  def first_disbursement_of_month?
    # No disbursement in given month, hence it must be first of the month
    @merchant.disbursements.by_month(@date.month, @date.year).count.zero?
  end

  def left_over_fee
    # no left over fee for this disbursement if it is not the first of the month
    return 0.0 unless first_disbursement_of_month?
    # no left over fee unless merchant joined before the month, disbursement is being generated
    return 0.0 if @merchant.live_on > @date.at_beginning_of_month

    # if it is less than minimum monthly fee,
    @merchant.minimum_monthly_fee > last_month_fee ? @merchant.minimum_monthly_fee - last_month_fee : 0.0
  end

  def create_disbursement(orders)
    return if orders.length.zero?

    ActiveRecord::Base.transaction do
      disbursement = Disbursement.create({
                                                    amount: orders.map(&:amount).inject(0, &:+),
                                                    disbursement_date: @date,
                                                    left_over_fee: ,
                                                    fee: orders.map(&:commission_amount).inject(0, &:+)
                                                  })
      insertable_orders = orders.map { |order| Hash[:order_id, order.id, :fee, order.commission_amount] }
      disbursement.orders_disbursements.insert_all(insertable_orders)
      orders.update_all(disbursed: true)
    end
  end
end
