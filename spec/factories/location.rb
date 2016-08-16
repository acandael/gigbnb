FactoryGirl.define do

  sequence :title do |n|
    Faker::Pokemon.name + n.to_s
  end

  factory :location do
    title "Lovely duplex"
    description Faker::Lorem.paragraph
    beds 2
    guests 3
    price 34.00
    factory :location_with_available_dates do
      after(:create) {|instance| create(:available_date, location: instance) }
      after(:create) {|instance| create(:available_date, location: instance,
      available_date: Date.today + 2.days) }
    end
  end
end
