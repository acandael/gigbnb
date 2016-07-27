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
     FactoryGirl.create(:profile, member_id: guest.id)
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
     visit member_location_path(host, location)
     expect {
       click_button "Reserve this location"
     }.to change(Reservation, :count)
     expect(location.reservations.count).to eq 1
     reservation = Reservation.last
     expect(reservation.member).to eq guest
     expect(current_path). to eq reservation_confirmation_path(Reservation.last)
     expect(page).to have_content "You reserved location #{location.title}"
     available_date = AvailableDate.last
     expect(available_date.reserved).to be true
    end
  end

  context "with invalid data" do
    it "does not reserve a location that's already booked" do
      FactoryGirl.create(:profile, member_id: guest.id)
      location= FactoryGirl.create(:location, member_id: guest.id)
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
      FactoryGirl.create(:reservation, start_date: Date.tomorrow, end_date: Date.today + 2.days, location_id: location.id)
      visit member_location_path(host, location)
      click_button "Reserve this location"
      expect(page).to have_content "Could not reserve the location"
      available_date = AvailableDate.last
      expect(available_date.reserved).to be false
    end
    it "does not reserve a location in the past" do
      FactoryGirl.create(:profile, member_id: guest.id)
      location= FactoryGirl.create(:location, member_id: guest.id)
      AvailableDate.create(location_id: location.id, available_date: Date.yesterday, reserved: false)
      visit member_location_path(host, location)
      select Date.today.year, from: "reservation[start_date(1i)]"
      select Date::MONTHNAMES[Date.today.month], from: "reservation[start_date(2i)]"
      select Date.yesterday.strftime("%d"), from: "reservation[start_date(3i)]"
      click_button "Reserve this location"
      expect(page).to have_content "Could not reserve the location"
      available_date = AvailableDate.last
      expect(available_date.reserved).to be false
    end
  end
end
