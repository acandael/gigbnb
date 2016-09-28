require "rails_helper"
require 'stripe_mock'

describe CreditCardService do

  let(:member) { FactoryGirl.create(:member) }
  let(:location) { FactoryGirl.create(:location_with_available_dates, member_id: member.id) }
  let(:stripe_helper) { StripeMock.create_test_helper }

  before do
    StripeMock.start
    @reservation = Reservation.new(
      location_id: location.id,
      member_id: member.id,
      start_date: Date.tomorrow,
      end_date: Date.today + 2.days
    )
    @token = stripe_helper.generate_card_token()
  end

  after do
  StripeMock.stop
  end

  describe "#charge_customer" do
    it "charges the customer" do
      customer_charge = CreditCardService.new({
      source: @token,
      location: location,
      reservation: @reservation
      }).charge_customer
      expect(customer_charge.id).to eq "test_ch_3"
    end
  end
end
