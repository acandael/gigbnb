require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:member) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
end
