FactoryGirl.define do
  factory :location do
    description Faker::Lorem.paragraph(2)

    factory :location_with_available_dates do
    	after(:create) {|instance| create(:available_date, location: instance) }
    	after(:create) {|instance| create(:available_date, location: instance, available_date: Date.today + 2.days) }
    end
  end
end
