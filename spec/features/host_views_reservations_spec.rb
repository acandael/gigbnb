require 'rails_helper'

feature "host views reservations" do
  let(:guest) { FactoryGirl.create(:member) }
  let(:host) { FactoryGirl.create(:member) }

  before do
    login_as(host, :scope => :member)
  end

  scenario "views the reservation", js: true do
        location = FactoryGirl.create(:location, member_id: host.id) 
    reservation = FactoryGirl.build(:reservation, member_id: guest.id, location_id: location.id) 
        reservation.save(validate: false)
        visit member_reservations_path(host)
        expect(page).to have_content "Reservation 1"
  end
end
