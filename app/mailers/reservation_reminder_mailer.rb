class ReservationReminderMailer < ApplicationMailer

  def send_reminder_to_guest(reservation)
    @greeting = "You have a pending reservation"
    @guest = reservation.member

    mail(to: @guest.email, subject: "reservation reminder")
  end

  def send_reminder_to_host(reservation)
    @greeting = "This is a reminder for a reservation"
    @location = reservation.location
    @host = @location.member
    @guest = reservation.member
    mail(to: @host.email, from: @guest.email, subject: "reservation reminder")
  end
end
