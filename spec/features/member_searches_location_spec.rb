require 'rails_helper'

feature "search location" do
  let(:member) { FactoryGirl.create(:member) }
  let(:profile) { FactoryGirl.create(:profile, member_id: member.id) }
  before do
    login_as(member, :scope => :member)
  end

  def fill_in_fields
    fill_in "start_date", with: Date.tomorrow
    fill_in "end_date", with: Date.tomorrow + 1.day
    select "Gent", from: "city"
    select "Oost-Vlaanderen", from: "region"
  end

  scenario "member searches for location with available date" do
  location_in_gent_no_dates = FactoryGirl.create(:location)
  location_in_gent_with_dates = FactoryGirl.create(:location_in_gent_with_available_dates)
  location_in_de_panne_with_dates = FactoryGirl.create(:location_in_de_panne_with_available_dates)
    visit root_path
    fill_in_fields
    click_button "Search"
    expect(page).to have_content(location_in_gent_with_dates.address.city)
    expect(page).not_to have_content(location_in_gent_no_dates.title)
    expect(page).not_to have_content(location_in_de_panne_with_dates.address.street)
  end
end
