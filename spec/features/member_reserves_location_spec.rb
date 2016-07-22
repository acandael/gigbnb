require 'rails_helper'

feature "reservations" do
  let(:guest) { FactoryGirl.create(:member) }
  let(:host) { FactoryGirl.create(:member) }
  let(:location) { FactoryGirl.create(:location, member_id: host.id) }
  before do
    login_as(guest, :scope => :member)
  end
  context "with valid data" do
    it "reserves a location" do
     visit member_location_path(host, location)
     expect {
       click_button "Reserve this location"
     }.to change(Reservation, :count)
     expect(location.reservations.count).to eq 1
     reservation = Reservation.last
     expect(reservation.member).to eq guest
     expect(current_path). to eq reservation_confirmation_path(Reservation.last)
     expect(page).to have_content "You reserved location #{location.title}"
    end
  end

  context "with invalid data" do

  end
end
