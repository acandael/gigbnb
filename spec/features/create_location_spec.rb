require 'rails_helper'

feature "location management" do
  let(:member) { FactoryGirl.create(:member) }
  let(:profile) { FactoryGirl.create(:profile, member_id: member.id) }
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
      profile.is_host = true
      profile.save
      visit member_profile_path(member, profile)
      click_link "Create Location"
      fill_in_fields
      click_button "Create Location"
      expect(page).to have_content("Successfully created location.")
      expect(page).to have_content("Add Images")
      picture_1_path = 'spec/fixtures/files/picture_1.jpg'
      attach_file "location[location_images_attributes][0][picture]", picture_1_path
      click_button "UPDATE & SAVE"
      expect(LocationImage.count).to eq 1
      expect(LocationImage.first.picture_order).to eq 1
      expect(LocationImage.first.picture_file_name).to eq "picture_1.jpg"
      
      location = Location.last
      expect(location.member_id).to eq member.id
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
      profile.is_host = true
      profile.save
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

    scenario "member deletes location" do
      profile.is_host = true
      profile.save
      location = FactoryGirl.create(:location)
      location.member_id = member.id
      location.save
      visit member_location_path(member, location)
      click_link "Delete"
      expect(page).to have_content("Successfully deleted location.")
    end

    scenario "member who is not a host doesn't see create location" do
      profile.is_host = false
      profile.save
      visit member_profile_path(member, profile)
      expect(page).not_to have_content "Create Location"
    end
  end

  context "with unvalid data" do
    scenario "member creates profile" do
      profile.is_host = true
      profile.save
      visit member_profile_path(member, profile)
      click_link "Create Location"
      fill_in "Title", with: ""
      click_button "Create Location"
      expect(page).to have_content "Could not create location."
    end

    scenario "member edits location" do
      profile.is_host = true
      profile.save
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
