require 'rails_helper'

feature "member views location" do
  let(:member) { FactoryGirl.create(:member) }
  let(:profile) { FactoryGirl.create(:profile, member_id: member.id) }
  let(:location) { FactoryGirl.create(:location, member_id: member.id) }
  let(:address) { FactoryGirl.create(:address, location_id: location.id) }

  before do
    login_as(member, :scope => :member)
  end

  scenario "views the location data" do
    @profile = profile
    visit member_location_path(member, location)
    expect(page).to have_content address.street
    expect(page).to have_content address.city
    expect(page).to have_content address.state
    expect(page).to have_content address.country_name(address.country)
    expect(page).to have_content location.description
    expect(page).to have_content "2 beds"
    expect(page).to have_content "3 guests"
    expect(page).to have_content location.price
  end
  
end
