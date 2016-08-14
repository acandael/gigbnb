require 'rails_helper'

RSpec.describe SearchForLocationService do
  it "returns a matching location" do
    location = FactoryGirl.create(:location)
    address = Address.create!(city: "Gent", region: "Oost-Vlaanderen", postal_code: 9000, country: "BE", location_id: location.id)
    AvailableDate.create(available_date: Date.tomorrow, location_id: location.id)

    address.geocode
    address.save
    params = { start_date: Date.tomorrow.to_s, end_date: (Date.tomorrow + 1.day).to_s, city: "Gent", region: "Oost-Vlaanderen" }
    matched_locations = SearchForLocationService.new(params).matches
    expect(matched_locations).to include(location)
    
  end
end
