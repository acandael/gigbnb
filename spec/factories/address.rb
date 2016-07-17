FactoryGirl.define do
  factory :address do
    street FFaker::Address.street_name
    city FFaker::Address.city
    postal_code 8370
    state FFaker::AddressUS.state
    country FFaker::Address.country_code
    latitude FFaker::Geolocation.lat
    longitude FFaker::Geolocation.lng
  end
end
