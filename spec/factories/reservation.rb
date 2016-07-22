FactoryGirl.define do
  factory :reservation do
    start_date Faker::Date.forward(1)
    end_date Faker::Date.forward(2)
  end
end
