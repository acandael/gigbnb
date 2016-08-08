require 'rails_helper'

RSpec.describe AvailableDate, type: :model do
  it { should belong_to(:location) }
  it { should validate_presence_of(:available_date) }
  it "returns upcoming available dates" do
    location = FactoryGirl.create(:location)
    upcoming  = AvailableDate.create(location_id: location.id, available_date: Date.tomorrow)
    expect(AvailableDate.upcoming).to include(upcoming)
  end

  it "returns unreserved days" do
    location = FactoryGirl.create(:location)
    unreserved  = AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
    reserved  = AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: true)
    expect(AvailableDate.unreserved).to include(unreserved)
    expect(AvailableDate.unreserved).not_to include(reserved)
  end

  it "returns available dates for reservation" do
    location = FactoryGirl.create(:location)
    available_for_reservation  = AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: false)
    date_range_array = Date.tomorrow..Date.today + 2.days
    not_available_for_reservation  = AvailableDate.create(location_id: location.id, available_date: Date.tomorrow, reserved: true)
    expect(AvailableDate.available_for_reservation(date_range_array)).to include(available_for_reservation)
    expect(AvailableDate.available_for_reservation(date_range_array)).not_to include(not_available_for_reservation)
  end
end
