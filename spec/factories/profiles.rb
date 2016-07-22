FactoryGirl.define do
  factory :profile do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    address Faker::Address.street_address
    city Faker::Address.city
    postal_code 9000
    state Faker::Address.state
    birthday "2016-05-24"
    cc_number 123456
    bio Faker::Lorem.paragraph
    profile_pic { File.new("#{Rails.root}/spec/fixtures/files/profile_pic.jpg") }
  end
end
