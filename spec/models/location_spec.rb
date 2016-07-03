require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should belong_to(:member) }
  it { should validate_presence_of(:title) }
end
