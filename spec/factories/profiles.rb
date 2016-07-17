FactoryGirl.define do
  factory :profile do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    address FFaker::Address.street_address
    city FFaker::Address.city
    postal_code 9000
    state FFaker::AddressUS.state
    birthday "2016-05-24"
    cc_number 123456
    bio FFaker::Lorem.paragraph
    profile_pic { File.new("#{Rails.root}/spec/fixtures/files/profile_pic.jpg") }
  end
end
