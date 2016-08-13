FactoryGirl.define do
  factory :address do
    street Faker::Address.street_name
    city Faker::Address.city
    postal_code 8370
    region Faker::Address.state
    country Faker::Address.country_code
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end
