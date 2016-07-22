require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "#confirm_available_dates" do
  	it "returns true if there are available_dates for the reservation" do
  		location = FactoryGirl.create(:location_with_available_dates)
  		reservation = Reservation.new(
  			start_date: Date.tomorrow, 
  			end_date: Date.today + 2.days,
  			location_id: location.id )

  		expect(reservation.confirm_available_dates).to eq true
  	end
  end

  describe "#confirm_no_reservation_overlap" do
  	it "returns true if there are available_dates for the reservation" do
  		location = FactoryGirl.create(:location_with_available_dates)
  		reservation = Reservation.new(
  			start_date: Date.tomorrow, 
  			end_date: Date.today + 2.days,
  			location_id: location.id )

  		expect(reservation.confirm_no_reservation_overlap).to eq true
  	end
  end

end
