FactoryGirl.define do
  factory :address do
    street FFaker::Address.street_name
    city FFaker::Address.city
    postal_code 8370
    state FFaker::AddressUS.state
    country FFaker::Address.country_code
    latitude 51.308193
    longitude 3.116116
  end
end
