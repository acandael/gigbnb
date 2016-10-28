require "rails_helper"
require 'stripe_mock'

RSpec.describe CustomerDisputeMailer, type: :mailer do

  describe "send_admin_customer_dispute" do

    before do
    StripeMock.start
    end

    after do
    StripeMock.stop
    end

    let(:event) { StripeMock.mock_webhook_event('charge.dispute.created') }
    let(:mail) { CustomerDisputeMailer.send_admin_customer_dispute(event) }

    it "renders the headers" do
      expect(mail.subject).to eq("Uh oh, a customer has submitted a dispute")
      expect(mail.to).to eq(["info@anthonycandaele.com"])
      expect(mail.from).to eq(["info@anthonycandaele.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Be sure to review the dispute below.")
    end
  end
end
