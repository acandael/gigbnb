require 'rails_helper'
require 'stripe_mock'

describe "Customer Dispute Events" do
  describe "charge.dispute.created" do

    before do
    StripeMock.start
    @event = StripeMock.mock_webhook_event('charge.dispute.created')
    ActionMailer::Base.deliveries.clear
    end

    after do
    StripeMock.stop
    ActionMailer::Base.deliveries.clear
    end

    it "sends an email to the admin" do
      post '/stripe-web-hooks', params: { id: @event.id }
      expect(ActionMailer::Base.deliveries.count).to eq 1
    end

    it "is successful" do
      post '/stripe-web-hooks', id: @event.id
      expect(response.code).to eq "200"
    end
  end
end
