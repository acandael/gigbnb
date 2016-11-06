# Preview all emails at http://localhost:3000/rails/mailers/reservation_cancellation_mailer
class ReservationCancellationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reservation_cancellation_mailer/send_cancellation_to_guest
  def send_cancellation_to_guest
    ReservationCancellationMailer.send_cancellation_to_guest
  end

  # Preview this email at http://localhost:3000/rails/mailers/reservation_cancellation_mailer/send_cancellation_to_host
  def send_cancellation_to_host
    ReservationCancellationMailer.send_cancellation_to_host
  end

end
