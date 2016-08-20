FactoryGirl.define do

  sequence :street do |n|
    Faker::Address.street_address + n.to_s
  end

  factory :address do
    street
    city "Gent"
    postal_code 9000
    region "Oost-Vlaanderen"
    country "BE"
    latitude 51.05
    longitude 3.71
    factory :address_in_de_panne do
      city "De Panne"
      region "West-Vlaanderen"
      latitude 51.09
      longitude 2.58
    end
  end
end
