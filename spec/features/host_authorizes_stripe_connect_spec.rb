require 'rails_helper'

feature "Host authorizes Stripe Connect" do

 let(:member) { FactoryGirl.create(:member) }

 before do
 login_as(member, scope: :member)
 end

 scenario "by clicking on link to Stripe" do
  visit payout_account_member_path(member)
  expect(page).to have_content "Get Paid with Stripe!"
  click_link "Connect With Stripe"
  expect(page).to have_content "Congrats on connecting your Stripe account!"
  member.reload
  expect(member.stripe_user_id).not_to eq nil
  expect(member.stripe_publishable_key).not_to eq nil
  expect(member.stripe_refresh_token).not_to eq nil
  expect(member.stripe_access_token).not_to eq nil
 end
end
