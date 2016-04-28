FactoryGirl.define do
  factory :recycle_location do
    name        "Östra Växjö"
    kind        :recycle_station
    materials   %w(glass cardboard plastic magazines metal)

    latitude     56.87306
    longitude    14.82639
    street_name "Kvarnvägen"
    zip_code    "352 41"
    city        "Växjö"
  end
end
