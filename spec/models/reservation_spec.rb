require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "#dates_are_available" do
  	it "returns true if there are available_dates for the reservation" do
  		location = FactoryGirl.create(:location_with_available_dates)
  		reservation = Reservation.new(
  			start_date: Date.tomorrow, 
  			end_date: Date.today + 2.days,
  			location_id: location.id )

  		expect(reservation.dates_are_available).to eq true
  	end
  end
end
