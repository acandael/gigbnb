class ReservationCancellationMailer < ApplicationMailer

  def send_cancellation_to_guest(reservation)
    @greeting = "You have cancelled a reservation"
    @guest = reservation.member
    @location = reservation.location

    mail(to: @guest.email, subject: "reservation cancellation")
  end

  def send_cancellation_to_host(reservation)
    @greeting = "A reservation was cancelled"
    @location = reservation.location
    @host = @location.member
    @guest = reservation.member
    profile = @guest.profile
    @first_name = profile.first_name
    @last_name = profile.last_name

    mail(to: @host.email, from: @guest.email, subject: "reservation cancellation")
  end
end
