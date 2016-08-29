class ReservationsController < ApplicationController

  def index
    @member = Member.find(params[:member_id])
    @reservations = @member.reservations
  end

  def new
    @reservation = Reservation.new 
  end

  def create
    member = Member.find(params[:member_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      location = @reservation.location
      reservation_array =  (@reservation.start_date..@reservation.end_date - 1.day).to_a
      AvailableDate.where(location_id: location.id).where(available_date: reservation_array).update_all(reserved: true)
      redirect_to reservation_confirmation_path(@reservation), notice: "Successfully created reservation."
    else
      flash[:error] = "Could not reserve the location"
      redirect_to member_location_path(member, @reservation.location), notice: "Could not create reservation."
    end
  end

  def confirmation
    @reservation = Reservation.find(params[:reservation_id])
  end

  private

  def reservation_params
    params.required(:reservation).permit(:start_date, :end_date, :member_id, :location_id)
  end
end
