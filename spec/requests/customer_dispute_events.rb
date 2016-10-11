require 'rails_helper'
require 'stripe_mock'

describe "Customer Dispute Events" do
  describe "charge.dispute.created" do

    before do
    StripeMock.start
    @event = StripeMock.mock_webhook_event('charge.dispute.created')
    end

    after do
    StripeMock.stop
    end

    it "is successful" do
      post '/stripe-web-hooks', id: @event.id
      expect(response.code).to eq "200"
    end
  end
end
