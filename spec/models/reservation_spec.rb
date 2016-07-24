require 'rails_helper'

RSpec.describe Reservation, type: :model do

  it { should belong_to(:location) }
  it { should belong_to(:member) }
  it "should not overlap the start date" do
    location = FactoryGirl.create(:location)
    location.reservations.create(start_date: Date.today, end_date: Date.tomorrow)
    reservation2 = location.reservations.build(start_date: Date.today, end_date: Date.tomorrow)
    reservation2.valid?
    expect(reservation2.errors[:base].any?).to be true
  end

  it "should not overlap the end date" do
    location = FactoryGirl.create(:location)
    location.reservations.create(start_date: Date.today, end_date: Date.tomorrow)
    reservation2 = location.reservations.build(start_date: Date.tomorrow, end_date: 3.days.from_now)
    reservation2.valid?
    expect(reservation2.errors[:base].any?).to be true
  end

  it "should not be in the past" do
    location = FactoryGirl.create(:location)
    reservation = location.reservations.create(start_date: Date.yesterday, end_date: 3.days.from_now)
    reservation.valid?
    expect(reservation.errors[:base].any?).to be true
  end
  
end
