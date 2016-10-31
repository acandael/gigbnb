class ReservationConfirmationMailer < ApplicationMailer

  def send_customer_reservation_confirmation(reservation)
    @body = "You have reserved the location below."
    @guest = reservation.member

    mail(to: @guest.email, subject: "reservation confirmation")
  end

  def send_host_reservation_confirmation(reservation)
    @body = "A customer reserved the location below"
    @location = reservation.location
    @host = @location.member
    @guest = reservation.member

    mail(to: @host.email, from: @guest.email, subject: "A customer reserved a location")
  end
end
