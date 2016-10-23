require 'rails_helper'

feature "member views profile" do
  let(:member) { FactoryGirl.create(:member) }
  let(:profile) { FactoryGirl.create(:profile) }
  before do
    login_as(member, :scope => :member)
  end
  
  scenario "sees the profile data" do
    visit member_profile_path(member, profile)
    expect(page).to have_content profile.fullname
    expect(page).to have_content profile.bio
    expect(page).to have_content profile.address
    expect(page).to have_content profile.city
    expect(page).to have_content profile.state
    expect(page).to have_content profile.postal_code
    expect(page).to have_content profile.birthday.strftime("%d %B %Y")
    expect(page).to have_content profile.cc_number
    expect(page).to have_css("img[src*='profile_pic']")
    expect(page).not_to have_link "Accept Stripe Payments"
    expect(page).not_to have_link "Create Location"
  end

  scenario "host sees links for hosts" do
    profile.is_host = true
    profile.save
    expect(page).not_to have_link "Accept Stripe Payments"
    expect(page).not_to have_link "Create Location"
  end
end
