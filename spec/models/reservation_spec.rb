require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { should belong_to(:location) }
  it { should belong_to(:member) }
end
