require 'rails_helper'

RSpec.describe Member, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:member)).to be_valid
  end
  it { should have_one(:profile) }
end
