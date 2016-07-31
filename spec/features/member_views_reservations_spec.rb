require 'rails_helper'

feature "member views his reservations" do
  let(:member) { FactoryGirl.create(:member) }
  let(:location) { FactoryGirl.create(:location, member_id: member.id) }
  let(:reservation) { FactoryGirl.create(:reservation, member_id: member.id, location_id: location.id) }

  before do
    login_as(member, :scope => :member)
  end

it "views the reservation", js: true do
   visit member_reservations_path(member)
   expect(page).to have_content "Reservation 1" 
  end
end
