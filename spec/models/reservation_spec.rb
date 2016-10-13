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

describe "#update_after_refund" do
  it "saves id for refund and makes dates available again" do
    location = FactoryGirl.create(:location_with_available_dates)
    reservation = Reservation.create(
      start_date: Date.tomorrow,
      end_date: Date.today + 2.days,
      location_id: location.id
    )
    reservation_array = (reservation.start_date..reservation.end_date - 1.day).to_a
    AvailableDate.where(location_id: location.id).where(available_date:
    reservation_array).update_all(reserved: true)
    id_for_refund = "re_123123123123"
    reservation.update_after_refund(id_for_refund)
    reservation.reload
    expect(reservation.id_for_refund).to eq id_for_refund
    available_date = AvailableDate.first
    expect(available_date.reserved).to eq false
  end
end


describe "not_cancelled scope" do
  it "returns reservations that have not been cancelled" do
    location = FactoryGirl.create(:location_with_available_dates)
    reservation = Reservation.create(
      start_date: Date.tomorrow,
      end_date: Date.today + 2.days,
      location_id: location.id )
    reservation2 = Reservation.create(
      start_date: Date.today + 2.days,
      end_date: Date.today + 3.days,
      location_id: location.id,
      id_for_refund: "re_123123123123" )

    reservations = Reservation.not_cancelled
    expect(reservations).to include(reservation)
    expect(reservations).to_not include(reservation2)
  end
end

