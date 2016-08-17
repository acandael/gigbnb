require 'rails_helper'

feature "Visitor searches for locations" do
  let(:member) { FactoryGirl.create(:member) }
  before :all do
    FactoryGirl.create_list(:location_with_available_dates, 30)
    @first_location = Location.first
    @last_location = Location.last
  end

  before do
    login_as(member, :scope => :member)
  end

  scenario "by visiting index page with no search and clicks to view more" do
    visit locations_path
    save_and_open_page
    expect(page).to have_content @first_location.title
    expect(page).not_to have_content @last_location.title
    click_link "Next"
    expect(page).to have_content @last_location.title
    expect(page).not_to have_content @first_location.title
  end
end
