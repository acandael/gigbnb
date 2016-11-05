class ReservationReminderJob < ActiveJob::Base
  queue_as :reservation_reminder

  def perform(reservation)
    if reservation.id_for_refund.blank?
      ReservationReminderMailer.send_reminder_to_guest(reservation).deliver_now
      ReservationReminderMailer.send_reminder_to_host(reservation).deliver_now
    end
  end
end
