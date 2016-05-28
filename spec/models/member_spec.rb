require 'rails_helper'

RSpec.describe Member, type: :model do
  it { should have_one(:profile) }
end
