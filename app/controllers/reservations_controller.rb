class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new 
  end

  def create
    member = Member.find(params[:member_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservation_confirmation_path(@reservation), notice: "Successfully created reservation."
    else
      flash[:error] = "Could not reserve the location"
      render member_location_path(member, @reservation.location)
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
