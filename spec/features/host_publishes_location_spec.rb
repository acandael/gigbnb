require 'rails_helper'

feature "Host publishes location" do
  let(:member) { FactoryGirl.create(:member) }
  let(:location) { FactoryGirl.create(:location) }

  before do
    login_as(member, scope: :member)
  end

  scenario "only when host has authorized stripe connect" do
    FactoryGirl.create(:profile, member_id: member.id, is_host: true)
    visit payout_account_member_path(member)
    click_link "Connect With Stripe"
    visit member_location_path(member, location) 
    expect(page).to have_content "Publish"
  end

  scenario "host who didn't authorize stripe cannot publish location" do
    FactoryGirl.create(:profile, member_id: member.id, is_host: true)
    visit member_location_path(member, location) 
    expect(page).not_to have_content "Publish"
  end
end
