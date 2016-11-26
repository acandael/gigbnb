require 'rails_helper'

feature "Guest cancels reservation" do
  let(:host) { FactoryGirl.create(:member, stripe_user_id: "acct_18wDXuEi4pi0JP9s", email: "marcel.candaele@skynet.be") } 
  let(:location) { FactoryGirl.create(:location_with_available_dates, member_id: host.id) }

  let(:member) { FactoryGirl.create(:member) }
  let(:profile) { FactoryGirl.create(:profile, member_id: member.id) }

  before do
    login_as(member, scope: :member)
    ActiveJob::Base.queue_adapter.enqueued_jobs.clear
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  scenario "by visiting index of upcoming reservations and clicking cancel", js: true do
    FactoryGirl.create(:profile, member_id: member.id, is_host: false)
    FactoryGirl.create(:profile, member_id: host.id, is_host: true)
    create_reservation
    reservation = Reservation.last
    visit member_reservations_path(member)
    click_link reservation.start_date.strftime("%m/%d/%Y")
    page.accept_confirm do
      click_link "Cancel Reservation"
    end
    expect(page).to have_content "Your reservation was successfully cancelled."
    expect(reservation).to have_attributes(id_for_refund: a_string_starting_with("re"))
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq 1
  end

  def create_reservation
    visit new_reservation_path(reservation: { start_date: Date.tomorrow, end_date: Date.tomorrow + 2.days, location_id: location.id, member_id: member.id })
    fill_in "card_number", with: "4242 4242 4242 4242"
    select "January"
    select "2020"
    fill_in "card_verification", with: "123"
    fill_in "address_zip", with: "10001"
    click_button "Book Now"
    sleep 10
    expect(Reservation.count).to eq 1
  end
end
