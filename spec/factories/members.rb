FactoryGirl.define do
  factory :member do
    email { Faker::Internet.email }
    password { Devise.friendly_token.first(8) }    
  end
end
