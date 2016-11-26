require 'rails_helper'

 
feature "Guest views upcoming reservations" do
  let(:host) { FactoryGirl.create(:member) }
  let!(:host_profile) { FactoryGirl.create(:profile, member_id: host.id, is_host: true) }
  let(:location) { FactoryGirl.create(:location_with_available_dates, member_id: host.id) }
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
    FactoryGirl.create(:profile, member_id: member.id, is_host: false)
    visit member_reservations_path(member)
    expect(page).to have_content @upcoming_reservation.start_date.strftime("%m/%d/%Y")
    expect(page).to_not have_content @past_reservation.start_date.strftime("%m/%d/%Y")
  end

  scenario "guest views reservation details" do
    FactoryGirl.create(:profile, member_id: member.id, is_host: false)
    visit member_reservations_path(member)
    click_link @upcoming_reservation.start_date.strftime("%m/%d/%Y")
    expect(page).to have_content location.title
    expect(page).to have_content @upcoming_reservation.start_date.strftime("%m/%d/%Y")
    expect(page).to have_content @upcoming_reservation.end_date.strftime("%m/%d/%Y")
    expect(page).to have_content location.address.street
    expect(page).to have_content location.address.city
    expect(page).to have_content location.address.postal_code
    expect(page).to have_content location.address.country
  end
end
