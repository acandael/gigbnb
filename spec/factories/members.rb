FactoryGirl.define do
  factory :member do
    email { FFaker::Internet.email }
    password { Devise.friendly_token.first(8) }    
  end
end
