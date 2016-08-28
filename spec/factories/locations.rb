FactoryGirl.define do

  sequence :title do |n|
    Faker::Pokemon.name + n.to_s
  end

  factory :location do
    title 
    description Faker::Lorem.paragraph(2)
    address_1 "151 W 34th St"
    city "New York"
    region "NY"
    country "US"
    zip "10001"

    factory :location_with_available_dates do
    	after(:create) {|instance| create(:available_date, location: instance) }
    	after(:create) {|instance| create(:available_date, location: instance, available_date: Date.today + 2.days) }
    end
  end
end
