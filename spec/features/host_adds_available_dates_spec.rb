require "rails_helper"

feature "managing available dates" do
  let(:member) { FactoryGirl.create(:member) }
  before do
    login_as(member, :scope => :member)
  end
  it "host adds available date" do
    FactoryGirl.create(:profile, member_id: member.id, is_host: true)
    location = FactoryGirl.create(:location, member_id: member.id)
    visit calendar_location_path(location)
    fill_in "Start date", with: Date.today
    fill_in "End date", with: Date.tomorrow
    click_button "Add available dates"
    expect(AvailableDate.count).to eq 2
    binding.pry
    expect(current_path).to eq calendar_location_path(location)
    expect(page).to have_content "Successfully added available dates"
  end
end
