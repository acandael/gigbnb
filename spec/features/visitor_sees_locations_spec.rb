require 'rails_helper'

feature "Visitor visits locations index page" do
  let(:member) { FactoryGirl.create(:member) }

  before do
    login_as(member, :scope => :member)
  end

  scenario "and sees locations" do
  location = FactoryGirl.create(:location)
  FactoryGirl.create(:profile, member_id: member.id, is_host: false)
  visit root_path
  click_link "See all Locations"
  expect(page).to have_content location.title
  click_link location.title
  expect(page).to have_content location.address.street
  end

end
