require 'stripe'

class CreditCardService
  def initialize(params)
    @source = params[:source]
    @location = params[:location]
    @reservation = params[:reservation]
  end

  def charge_customer
    set_charge_attributes
    Stripe::Charge.create({
      amount: @amount, #required
      source: @source, #required
      currency: "eur", #required
      destination: @destination, #required
      description: @description,#optional
      statement_descriptor: @statement_descriptor, #optional
      application_fee: @application_fee #optional
    })
  end

  def refund_customer
    charge = Stripe::Charge.retrieve(@reservation.id_for_credit_card_charge)
    charge.refund
  end

  private

  def set_charge_attributes
    set_amount
    set_application_fee(@amount)
    host = @location.member
    @destination = host.stripe_user_id
    @description = "Room booking"
    @statement_descriptor = "HackerBnB booking"
  end

  def set_amount
    number_of_nights = (@reservation.start_date..@reservation.end_date - 1.day).count
    @amount = ((number_of_nights * @location.price) * 100).to_i
  end

  def set_application_fee(amount)
    @application_fee = ((amount * 0.05).ceil).to_i * 100
  end
end
