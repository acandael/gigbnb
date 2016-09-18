class ReservationsController < ApplicationController

  def index
    @member = Member.find(params[:member_id])
    @reservations = @member.reservations
  end

  def new
    @reservation = Reservation.new(reservation_params)
    @location = @reservation.location
  end

  def create
    # member = Member.find(params[:member_id])
    @reservation = Reservation.new(reservation_params)
    @location = @reservation.location
    @token = params[:stripe_token]

    if @reservation.valid?
      begin
      @customer_charge = charge_customer(@token, @location, @reservation)
      @reservation.id_for_credit_card_charge = @customer_charge.id
      rescue Stripe::CardError => e
      body = e.json_body
      message = body[:error][:message]
      flash[:alert] = message
      end
    else
      flash[:alert] = "Some of the dates of your reservation are not available.
      Please try different dates."
    end
    respond_to do |format|
      if !@customer_charge.nil?
        @reservation.save
        reservation_array = (@reservation.start_date..@reservation.end_date -
        1.day).to_a
        AvailableDate.where(location_id: @location.id).where(date_available:
        reservation_array).update_all(reserved: true)
        format.html { redirect_to confirmation_reservation_path(@reservation),
        notice: "Reservation successfully created." }
      else
        format.html {redirect_to new_reservation_path(
        reservation: {start_date: @reservation.start_date,
        end_date: @reservation.end_date, location_id: @location.id})}
      end
    end
  end

  def confirmation
    @reservation = Reservation.find(params[:reservation_id])
  end

  private

  def reservation_params
    params.required(:reservation).permit(:start_date, :end_date, :member_id, :location_id)
  end

  def charge_customer(source, location, reservation)
    CreditCardService.new({
    source: source,
    location: location,
    reservation: reservation
    }).charge_customer
  end
end
