class ReservationConfirmationMailer < ApplicationMailer

  def send_customer_reservation_confirmation(guest)
    @body = "You have reserved the location below."

    mail(to: guest.email, subject: "reservation confirmation")
  end

  def send_host_reservation_confirmation(location, guest)
    @body = "A customer reserved the location below"
    @host = location.member
    @guest = guest

    mail(to: @host.email, from: @guest.email, subject: "A customer reserved a location")
  end
end
