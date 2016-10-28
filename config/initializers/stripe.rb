Stripe.api_key = ENV["stripe_secret_key"]
  
StripeEvent.subscribe 'charge.dispute.created' do |event|
  CustomerDisputeMailer.send_admin_customer_dispute(event).deliver_now
end

 
