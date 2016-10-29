require "rails_helper"

RSpec.describe ReservationConfirmationMailer, type: :mailer do
  describe "send_customer_reservation_confirmation" do
    let(:guest) { FactoryGirl.create(:member) } 
    let(:host) { FactoryGirl.create(:member, email: "info@anthonycandaele.com") }
    let(:location°) { FactoryGirl.create(:location, member_id: host.id) }
    let(:reservation) { FactoryGirl.create(:reservation, member_id: guest.id, location_id: location.id) }
    let(:mail) { ReservationConfirmationMailer.send_customer_reservation_confirmation(guest) }

    before do
      login_as(guest, :scope => :member)
    end

    it "renders the headers" do
      expect(mail.subject).to eq("reservation confirmation")
      expect(mail.to).to eq([guest.email])
      expect(mail.from).to eq(["info@anthonycandaele.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("You have reserved the location below.")
    end
  end

  describe "send_host_reservation_confirmation" do
    let(:guest) { FactoryGirl.create(:member) } 
    let(:host) { FactoryGirl.create(:member) }
    let(:location) { FactoryGirl.create(:location, member_id: host.id) }
    let(:reservation) { FactoryGirl.create(:reservation, member_id: guest.id, location_id: location.id) }
    let(:mail) { ReservationConfirmationMailer.send_host_reservation_confirmation(location, guest) }

    before do
      login_as(guest, :scope => :member)
    end

    it "renders the headers" do
      expect(mail.subject).to eq("A customer reserved a location")
      expect(mail.to).to eq([host.email])
      expect(mail.from).to eq([guest.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("A customer reserved the location below.")
    end
  end

end
