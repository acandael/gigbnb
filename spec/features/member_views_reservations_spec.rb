require 'rails_helper'

feature "member views his reservations" do
  let(:member) { FactoryGirl.create(:member) }

  before do
    login_as(member, :scope => :member)
  end

    scenario "views the reservation", js: true do
      FactoryGirl.create(:profile, member_id: member.id, is_host: false)
        location = FactoryGirl.create(:location, member_id: member.id) 
    reservation = FactoryGirl.build(:reservation, member_id: member.id, location_id: location.id) 
        reservation.save(validate: false)
        
    visit member_reservations_path(member)

    expect(page).to have_content "Reservation 1" 
  end
end
