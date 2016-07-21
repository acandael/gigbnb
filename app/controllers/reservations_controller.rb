class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new 
  end

  def create
    @reservation = Reservation.create(reservation_params)
    if @reservation.save
      redirect_to reservation_confirmation_path(@reservation), notice: "Successfully created reservation."
      
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
