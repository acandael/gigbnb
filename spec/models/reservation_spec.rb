require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:location) { FactoryGirl.create(:location) }
  let(:reservation1) { FactoryGirl.create(:reservation, start_date: Date.today) }
  let(:reservation2) { FactoryGirl.create(:reservation, start_date: Date.today) }

  it { should belong_to(:location) }
  it { should belong_to(:member) }
  it "should not overlap the start date" do
    location.reservations << reservation1
    location.reservations << reservation2
    location.save
    reservation2.valid?
    expect(reservation2.errors[:base].any?).to be true
  end
end
