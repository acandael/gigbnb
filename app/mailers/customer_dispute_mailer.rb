class CustomerDisputeMailer < ApplicationMailer

  def send_admin_customer_dispute(event)
    @event = event

    mail(to: "info@anthonycandaele.com", subject: "Uh oh, a customer
    has submitted a dispute")
  end
end
