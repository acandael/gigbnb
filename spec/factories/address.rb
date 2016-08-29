FactoryGirl.define do

  # sequence :street do |n|
  #   Faker::Address.street_address + n.to_s
  # end

  factory :address do
    # street
    # city "Gent"
    # postal_code 9000
    # region "Oost-Vlaanderen"
    # country "BE"
    # latitude 51.05
    # longitude 3.71
    factory :address_in_de_panne do
      city "De Panne"
      region "West-Vlaanderen"
      street "De Pannelaan 68"
      postal_code 8660
      latitude 51.09
      longitude 2.58
    end
    factory :address_in_gent do
      city "Gent"
      region "Oost-Vlaanderen"
      street "Smidsestraat 36"
      postal_code 9000
      country "BE"
      latitude 51.04
      longitude 3.71
    end
  end
end
