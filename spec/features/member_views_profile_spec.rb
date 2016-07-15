require 'rails_helper'

feature "member views profile" do
  let(:member) { FactoryGirl.create(:member) }
  let(:profile) { FactoryGirl.create(:profile) }
  before do
    login_as(member, :scope => :member)
  end
  
  it "sees the profile data" do
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
  end

  it "host sees Create Location link" do
    profile.is_host = true
    profile.save
    visit member_profile_path(member, profile)
    expect(page).to have_content "Create Location"
  end

  it "guest does not see Create Location link" do
    visit member_profile_path(member, profile)
    expect(page).not_to have_content "Create Location"
  end
end
