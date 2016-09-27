FactoryGirl.define do

  sequence :title do |n|
    Faker::Pokemon.name + n.to_s
  end

  factory :location do
    title
    description Faker::Lorem.paragraph
    beds 2
    guests 3
    price 34.00
    after(:create) {|instance| create(:address_in_gent, location: instance) }
    factory :location_with_available_dates do
      after(:create) {|instance| create(:available_date, location: instance) }
      after(:create) {|instance| create(:available_date, location: instance,
      available_date: Date.today + 2.days) }
    end
    factory :location_in_gent_with_available_dates do
      after(:create) {|instance| create(:available_date, location: instance) }
    end
    factory :location_in_de_panne_with_available_dates do
      after(:create) {|instance| create(:address_in_de_panne, location: instance) }
      after(:create) {|instance| create(:available_date, location: instance) }
    end
  end
end
