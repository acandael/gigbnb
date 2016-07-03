require 'rails_helper'

feature "location management" do
  let(:member) { FactoryGirl.create(:member) }
  before do
    login_as(member, :scope => :member)
  end

  def fill_in_fields
    fill_in "Title", with: "Lovely Duplex"
    fill_in "Description", with: "appartment in the centre of Brussels"
    fill_in "Address", with: "Smidsestraat 36"
    fill_in "City", with: "Brussel"
    fill_in "Postal code", with: 1000
    fill_in "State", with: "Oost-Vlaanderen"
    select "Belgium", from: "Country"
    fill_in "Number of beds", with: 2
    fill_in "Number of guests", with: 3
    fill_in "Price", with: 34.00
  end
  context "with valid data" do
    scenario "member creates location" do
      visit member_locations_path(member)
      click_link "Create Location"
      fill_in_fields
      click_button "Create Location"
      expect(page).to have_content("Successfully created location.")
      location = Location.last
      expect(current_path).to eq member_location_path(member, location)
      expect(page).to have_content "Lovely Duplex"
      expect(page).to have_content "appartment in the centre of Brussels"
      expect(page).to have_content "Smidsestraat 36"
      expect(page).to have_content "Brussel"
      expect(page).to have_content "1000"
      expect(page).to have_content "Oost-Vlaanderen"
      expect(page).to have_content "Belgium"
      expect(page).to have_content "2"
      expect(page).to have_content "3"
      expect(page).to have_content "34.00"
    end
    scenario "member edits location" do
      location = FactoryGirl.create(:location)
      location.member_id = member.id
      location.save
      visit member_location_path(member, location)
      click_link "Edit"
      fill_in "Title", with: "new title"
      click_button "Update Location"
      expect(page).to have_content("Successfully updated location.")
      expect(current_path).to eq member_location_path(member, location)
    end
  end

  context "with unvalid data" do
    scenario "member creates profile" do
      visit member_locations_path(member)
      click_link "Create Location"
      fill_in "Title", with: ""
      click_button "Create Location"
      expect(page).to have_content "Could not create location."
    end

    scenario "member edits location" do
      location = FactoryGirl.create(:location)
      location.member_id = member.id
      location.save
      visit member_location_path(member, location)
      click_link "Edit"
      fill_in "Title", with: ""
      click_button "Update Location"
      expect(page).to have_content("Could not update location.")
      expect(current_path).to eq member_location_path(member, location)
    end
  end
end
