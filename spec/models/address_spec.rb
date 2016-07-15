require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { FactoryGirl.create(:address) }
  it { should belong_to(:location) }
  it { should validate_numericality_of(:postal_code) }

  it "returns the country name" do
    expect(address.country_name("BE")).to eq "Belgium"
  end
  it "should return the full address" do
    expect(address.full_street_address).to eq "#{address.street}, #{address.city}, #{address.postal_code}, #{address.state}, #{address.country}"
  end
  it "notices when address is changed" do
    address.city = "Gent"
    expect(address.address_changed?).to be_truthy
  end
end
