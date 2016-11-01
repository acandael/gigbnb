# Preview all emails at http://localhost:3000/rails/mailers/reservation_confirmation_mailer
class ReservationConfirmationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reservation_confirmation_mailer/send_customer_reservation_confirmation
  def send_customer_reservation_confirmation
    reservation = Reservation.last
    ReservationConfirmationMailer.send_customer_reservation_confirmation(reservation)
  end

  # Preview this email at http://localhost:3000/rails/mailers/reservation_confirmation_mailer/send_host_reservation_confirmation
  def send_host_reservation_confirmation
    reservation = Reservation.last
    ReservationConfirmationMailer.send_host_reservation_confirmation(reservation)
  end

end
