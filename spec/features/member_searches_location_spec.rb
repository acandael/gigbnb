require 'rails_helper'

feature "search location" do
  let(:member) { FactoryGirl.create(:member) }
  let(:profile) { FactoryGirl.create(:profile, member_id: member.id) }
  before do
    login_as(member, :scope => :member)
  end

  def fill_in_fields
    fill_in "start_date", with: Date.tomorrow
    fill_in "end_date", with: Date.tomorrow + 1.day
    select "Gent", from: "city"
    select "Oost-Vlaanderen", from: "region"
  end

  scenario "member searches for location with available date" do
    location = FactoryGirl.create(:location)
    location2 = FactoryGirl.create(:location)
    location3 = FactoryGirl.create(:location)
    Address.create(street: "Smidsestraat 36", city: "Gent", postal_code: 9000, region: "Oost-Vlaanderen", country: "BE", latitude: 51.05, longitude: 3.72, location_id: location.id)
    Address.create(street: "Dynastielaan 10", city: "De Panne", postal_code: 8660, region: "West-Vlaanderen", country: "BE", latitude: 51.09, longitude: 2.57, location_id: location2.id)
    Address.create(street: "Universiteitstraat 8", city: "Gent", postal_code: 9000, region: "Oost-Vlaanderen", country: "BE", latitude: 51.05, longitude: 3.72, location_id: location3.id)
    AvailableDate.create(available_date: Date.tomorrow, location_id: location.id)
    AvailableDate.create(available_date: Date.tomorrow, location_id: location2.id)
    visit root_path
    fill_in_fields
    click_button "Search"
    expect(page).to have_content(location.address.city)
    expect(page).to have_content(location.address.street)
    expect(page).not_to have_content(location2.address.city)
    expect(page).not_to have_content(location3.address.street)
  end
end
