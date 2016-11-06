class ReservationCancellationJob < ActiveJob::Base
  queue_as :reservation_cancellation

  def perform(reservation)
    ReservationCancellationMailer.send_cancellation_to_guest(reservation).deliver_now
    ReservationCancellationMailer.send_cancellation_to_host(reservation).deliver_now
  end
end
