require 'rails_helper'

 
feature "Guest views upcoming reservations" do
  let(:location) { FactoryGirl.create(:location_with_available_dates) }
  let(:member) { FactoryGirl.create(:member) }
  
  before do
    login_as(member, scope: :member)
    @upcoming_reservation = Reservation.create(
    location_id: location.id,
    member_id: member.id,
    start_date: Date.tomorrow,
    end_date: Date.current + 2.days)

    @past_reservation = Reservation.new(
    location_id: location.id,
    member_id: member.id,
    start_date: Date.current - 2.days,
    end_date: Date.yesterday)
    @past_reservation.save(validate: false)
  end

  scenario "by visiting index of upcoming reservations" do
    visit member_reservations_path(member)
    expect(page).to have_content @upcoming_reservation.start_date.strftime("%m/%d/%Y")
    expect(page).to_not have_content @past_reservation.start_date.strftime("%m/%d/%Y")
  end
end
