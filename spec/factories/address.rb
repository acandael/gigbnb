FactoryGirl.define do
  factory :address do
    street Faker::Address.street_name
    city "New York"
    postal_code 8370
    region "NY"
    country Faker::Address.country_code
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end
