require 'rails_helper'

feature "signing in" do
  let(:member) { FactoryGirl.create(:member) }

  def fill_in_signin_fields
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password
    click_button "Log in"
  end

  scenario "visiting the site to sign in" do
    visit root_path
    click_link "Sign in"
    fill_in_signin_fields
    expect(page).to have_content("Signed in successfully.")
  end
end
