FactoryGirl.define do
  factory :user do
    email       "test@test.se"
    password    "test"
    role        "admin"
  end
end
