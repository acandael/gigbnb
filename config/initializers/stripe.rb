Stripe.api_key = ENV["stripe_secret_key"]
  
StripeEvent.subscribe 'charge.dispute.created' do |event|
end
