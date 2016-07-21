require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should belong_to(:member) }
  it { should have_one(:address) }
  it { should have_many(:reservations) }
  it { should have_many(:location_images) }
  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:beds) }
  it { should validate_numericality_of(:guests) }
  it { should validate_numericality_of(:price) }
end
