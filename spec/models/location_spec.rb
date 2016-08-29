require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should belong_to(:member) }
  it { should have_one(:address) }
  it { should have_many(:reservations) }
  it { should have_many(:location_images) }
  it { should have_many(:available_dates) }
  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:beds) }
  it { should validate_numericality_of(:guests) }
  it { should validate_numericality_of(:price) }

  it "creates available dates" do
    start_date = Date.today
    end_date = Date.tomorrow
    location = FactoryGirl.create(:location)
    location.create_available_dates(start_date, end_date)
    expect(AvailableDate.count).to eq 2
  end

  it "returns the future dates" do
    location = FactoryGirl.create(:location)
    FactoryGirl.create(:address_in_gent, location_id: location.id)
    AvailableDate.create(available_date: Date.tomorrow, reserved: false, location_id: location.id)
    AvailableDate.create(available_date: Date.today + 2.days, reserved: false, location_id: location.id)
    future_available_dates = location.future_available_dates
    expect(future_available_dates.count).to eq 2
    location.future_available_dates do |date|
      expect(date.reserved).to be false
    end
  end

  it "searches the nearby location" do
    location = FactoryGirl.create(:location)
    Address.create!(city: "Gent", region: "Oost-Vlaanderen", postal_code: 9000, country: "BE", latitude: 51.05, longitude: 3.70, location_id: location.id)
    address_search = "Gent, Oost-Vlaanderen"
    expect(Location.nearby(address_search)).to include(location)
  end

  it "searches for locations with available dates for reservation" do
    location = FactoryGirl.create(:location)
    available_date = AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
    date_range_array = Date.tomorrow..Date.today + 2.days
    Address.create!(city: "Gent", region: "Oost-Vlaanderen", postal_code: 9000, country: "BE", latitude: 51.05, longitude: 3.70, location_id: location.id)
    expect(Location.with_available_dates(date_range_array)).to include(location)
  end
end
