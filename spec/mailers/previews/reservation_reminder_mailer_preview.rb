# Preview all emails at http://localhost:3000/rails/mailers/reservation_reminder_mailer
class ReservationReminderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reservation_reminder_mailer/send_reminder_to_guest
  def send_reminder_to_guest
    ReservationReminderMailer.send_reminder_to_guest
  end

  # Preview this email at http://localhost:3000/rails/mailers/reservation_reminder_mailer/send_reminder_to_host
  def send_reminder_to_host
    ReservationReminderMailer.send_reminder_to_host
  end

end
