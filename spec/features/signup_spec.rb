require 'rails_helper'

feature "sign up" do
  def fill_in_signup_fields
    fill_in "member[email]", with: "test@user.be"
    fill_in "member[password]", with: "test1234"
    fill_in "member[password_confirmation]", with: "test1234"
    click_button "Sign up"
  end

  scenario "visiting the site to sign up" do
    visit root_path
    click_link "Sign in"
    click_link "Sign up"
    fill_in_signup_fields
    expect(page).to have_content("You have signed up successfully.")
  end
end
