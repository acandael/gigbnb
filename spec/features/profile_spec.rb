require 'rails_helper'

feature "profile management" do
  let(:member) { FactoryGirl.create(:member) }

  def fill_in_signin_fields
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password
    click_button "Log in"
  end
  context "with valid data" do
    scenario "member creates profile" do
      visit root_path
      click_link "Sign in"
      fill_in_signin_fields
      click_link "Profile"
      fill_in "First Name", with: "Joe"
      fill_in "Last Name", with: "Doe"
      fill_in "Address", with: "main street 36"
      fill_in "City", with: "New York"
      fill_in "Postal Code", with: 9000
      fill_in "State", with: "NY"
      select "2016", from: "profile[birthday(1i)]"
      select "May", from: "profile[birthday(2i)]"
      select "21", from: "profile[birthday(3i)]"
      fill_in "Credit Card Number", with: "12345678"
      click_button "Create Profile"
      expect(page).to have_content("Successfully created profile.")
    end
  end

  context "with invalid data" do
    scenario "member creates profile" do
      visit root_path
      click_link "Sign in"
      fill_in_signin_fields
      click_link "Profile"
      fill_in "First Name", with: ""
      fill_in "Last Name", with: ""
      fill_in "Address", with: "main street 36"
      fill_in "City", with: "New York"
      fill_in "Postal Code", with: 9000
      fill_in "State", with: "NY"
      select "2016", from: "profile[birthday(1i)]"
      select "May", from: "profile[birthday(2i)]"
      select "21", from: "profile[birthday(3i)]"
      fill_in "Credit Card Number", with: "12345678"
      click_button "Create Profile"
      save_and_open_page
      expect(page).to have_content("Could not create profile.")
    end
  end
end
