class ReservationCancellationMailer < ApplicationMailer

  def send_cancellation_to_guest(reservation)
    @greeting = "You have cancelled a reservation"
    @guest = reservation.member

    mail(to: @guest.email, subject: "reservation cancellation")
  end

  def send_cancellation_to_host(reservation)
    @greeting = "A reservation was cancelled"
    @location = reservation.location
    @host = @location.member
    @guest = reservation.member

    mail(to: @host.email, from: @guest.email, subject: "reservation cancellation")
  end
end
