# Preview all emails at http://localhost:3000/rails/mailers/customer_dispute_mailer
class CustomerDisputeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/customer_dispute_mailer/send_admin_customer_dispute
  def send_admin_customer_dispute
    event = Stripe::Event.retrieve("evt_199Gp6GpFFIgtGQjJhL4AnC8")

    CustomerDisputeMailer.send_admin_customer_dispute(event)
  end

end
