require "rails_helper"

feature "managing available dates" do
  let(:member) { FactoryGirl.create(:member) }
  before do
    login_as(member, :scope => :member)
  end
  context "with valid data" do
    scenario "host adds available date" do
      FactoryGirl.create(:profile, member_id: member.id, is_host: true)
      location = FactoryGirl.create(:location, member_id: member.id)
      FactoryGirl.create(:address, location_id: location.id)
      visit member_location_path(member, location)
      click_link "Add available dates for this location"
      fill_in "Start date", with: Date.today
      fill_in "End date", with: Date.tomorrow
      click_button "Add available dates"
      expect(AvailableDate.count).to eq 2
      expect(current_path).to eq calendar_location_path(location)
      expect(page).to have_content "Successfully added available dates"
      available_date = AvailableDate.last
      expect(available_date.reserved).to be false
    end

    scenario "doesn't see add available dates link when not a host" do
      FactoryGirl.create(:profile, member_id: member.id, is_host: false)
      location = FactoryGirl.create(:location, member_id: member.id)
      visit member_location_path(member, location)
      expect(page).not_to have_link "Add available dates for this location"
    end
  end

  context "with invalid data" do
    scenario "does not add an available date" do
      FactoryGirl.create(:profile, member_id: member.id, is_host: true)
      location = FactoryGirl.create(:location, member_id: member.id)
      visit calendar_location_path(location)
      fill_in "Start date", with: ""
      fill_in "End date", with: Date.tomorrow
      click_button "Add available dates"
      expect(page).to have_content "The available date could not be added"
    end
  end
end
