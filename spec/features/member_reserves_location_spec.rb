require 'rails_helper'

feature "reservations" do
  let(:guest) { FactoryGirl.create(:member) }
  let(:host) { FactoryGirl.create(:member, stripe_user_id: "acct_2N9rwPho2QXMroqhEhGh") }
  let(:location) { FactoryGirl.create(:location, member_id: host.id) }
  before do
    login_as(guest, :scope => :member)
  end
  context "with valid data" do
    scenario "reserves a location", js: true do
     FactoryGirl.create(:address_in_gent, location_id: location.id)
     FactoryGirl.create(:profile, member_id: guest.id)
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
     visit member_location_path(host, location)
     click_button "Pay Now"
     fill_in "card_number", with: "4242 4242 4242 4242"
     select "January"
     select "2020"
     fill_in "card_verification", with: "123"
     fill_in "address_zip", with: "10001"
     click_button "Book Now"
     sleep 5
     expect(Reservation.last).to have_attributes(id_for_credit_card_charge: a_string_starting_with("ch"))
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
    scenario "does not reserve a location that's already booked" do
      FactoryGirl.create(:profile, member_id: guest.id)
      location= FactoryGirl.create(:location, member_id: guest.id)
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
      FactoryGirl.create(:address_in_gent, location_id: location.id)
      FactoryGirl.create(:reservation, start_date: Date.tomorrow, end_date: Date.today + 2.days, location_id: location.id)
      visit member_location_path(host, location)
      click_button "Pay Now"
      expect(page).to have_content "Could not reserve the location."
      available_date = AvailableDate.last
      expect(available_date.reserved).to be false
    end

    scenario "charge is declined", js: true do
     FactoryGirl.create(:address_in_gent, location_id: location.id)
     FactoryGirl.create(:profile, member_id: guest.id)
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
     visit member_location_path(host, location)
     click_button "Pay Now"
     fill_in "card_number", with: "4000000000000002"
     select "January"
     select "2020"
     fill_in "card_verification", with: "123"
     fill_in "address_zip", with: "10001"
     click_button "Book Now"
     sleep 5
     expect(page).to have_content "The card was declined."
    end

    scenario "stripe returns error for invalid cvc-code", js: true do
     FactoryGirl.create(:address_in_gent, location_id: location.id)
     FactoryGirl.create(:profile, member_id: guest.id)
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
     visit member_location_path(host, location)
     click_button "Pay Now"
     fill_in "card_number", with: "4242 4242 4242 4242"
     select "January"
     select "2020"
     fill_in "card_verification", with: "99"
     fill_in "address_zip", with: "10001"
     click_button "Book Now"
     sleep 5
     expect(page).to have_content "The card's security code is incorrect."
    end

    scenario "card has expired", js: true do
     FactoryGirl.create(:address_in_gent, location_id: location.id)
     FactoryGirl.create(:profile, member_id: guest.id)
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
     visit member_location_path(host, location)
     click_button "Pay Now"
     fill_in "card_number", with: "4000000000000069"
     select "January"
     select "2020"
     fill_in "card_verification", with: "123"
     fill_in "address_zip", with: "10001"
     save_and_open_page
     click_button "Book Now"
     sleep 5
     expect(page).to have_content "The card has expired."
    end

    scenario "processing error", js: true do
     FactoryGirl.create(:address_in_gent, location_id: location.id)
     FactoryGirl.create(:profile, member_id: guest.id)
      AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
     visit member_location_path(host, location)
     click_button "Pay Now"
     fill_in "card_number", with: "4000000000000119"
     select "January"
     select "2020"
     fill_in "card_verification", with: "123"
     fill_in "address_zip", with: "10001"
     click_button "Book Now"
     sleep 5
     expect(page).to have_content "An error occurred while processing the card."
    end
  end
end
