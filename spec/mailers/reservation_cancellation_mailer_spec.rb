require "rails_helper"

RSpec.describe ReservationCancellationMailer, type: :mailer do
  describe "send_cancellation_to_guest" do

    let(:guest) { FactoryGirl.create(:member) } 
    let(:host) { FactoryGirl.create(:member, email: "info@anthonycandaele.com") }
    let(:location) { FactoryGirl.create(:location, member_id: host.id, published: true) }
    let!(:guest_profile) { FactoryGirl.create(:profile, member_id: guest.id) }
    let!(:host_profile) { FactoryGirl.create(:profile, member_id: host.id) }

    it "renders the headers" do
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
      reservation = FactoryGirl.create(:reservation, member_id: guest.id, location_id: location.id)
      mail = ReservationCancellationMailer.send_cancellation_to_guest(reservation)
      expect(mail.subject).to eq("reservation cancellation")
      expect(mail.to).to eq([guest.email])
      expect(mail.from).to eq(["info@anthonycandaele.com"])
    end

    it "renders the body" do
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
      reservation = FactoryGirl.create(:reservation, member_id: guest.id, location_id: location.id)
      mail = ReservationCancellationMailer.send_cancellation_to_guest(reservation)
      expect(mail.body.encoded).to match("You have cancelled a reservation")
    end
  end

  describe "send_cancellation_to_host" do
    let(:guest) { FactoryGirl.create(:member) } 
    let(:host) { FactoryGirl.create(:member, email: "info@anthonycandaele.com") }
    let(:location) { FactoryGirl.create(:location, member_id: host.id, published: true) }
    let!(:guest_profile) { FactoryGirl.create(:profile, member_id: guest.id) }
    let!(:host_profile) { FactoryGirl.create(:profile, member_id: host.id) }

    it "renders the headers" do
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
      reservation = FactoryGirl.create(:reservation, member_id: guest.id, location_id: location.id)
      mail = ReservationCancellationMailer.send_cancellation_to_host(reservation)
      expect(mail.subject).to eq("reservation cancellation")
      expect(mail.to).to eq([host.email])
      expect(mail.from).to eq([guest.email])
    end

    it "renders the body" do
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
      reservation = FactoryGirl.create(:reservation, member_id: guest.id, location_id: location.id)
      mail = ReservationCancellationMailer.send_cancellation_to_host(reservation)
      expect(mail.body.encoded).to match("A reservation was cancelled")
    end
  end

end
