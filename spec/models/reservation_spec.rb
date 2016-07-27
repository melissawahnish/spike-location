require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "#no_available_dates?" do
  	it "returns true if there are not available_dates for the reservation" do
  		location = FactoryGirl.create(:location)
  		reservation = Reservation.new(
  			start_date: Date.tomorrow, 
  			end_date: Date.today + 2.days,
  			location_id: location.id )

  		expect(reservation.dates_unavailable?).to eq true
  	end
  	it "returns false if there are available_dates for the reservation" do
  		location = FactoryGirl.create(:location_with_available_dates)
  		reservation = Reservation.new(
  			start_date: Date.tomorrow, 
  			end_date: Date.today + 2.days,
  			location_id: location.id )

  		expect(reservation.dates_unavailable?).to eq false
  	end
  end

  describe "#reservation_overlap?" do
  	it "returns true if there are reservations during that date range" do
  		location = FactoryGirl.create(:location_with_available_dates)
  		existing_reservation = Reservation.create(
  			start_date: Date.tomorrow, 
  			end_date: Date.today + 2.days,
  			location_id: location.id )
  		reservation = Reservation.new(
  			start_date: Date.tomorrow, 
  			end_date: Date.today + 2.days,
  			location_id: location.id )

  		expect(reservation.reservation_overlap?).to eq true
  	end
  	it "returns false if there are not reservations during that date range" do
  		location = FactoryGirl.create(:location_with_available_dates)
  		reservation = Reservation.new(
  			start_date: Date.tomorrow, 
  			end_date: Date.today + 2.days,
  			location_id: location.id )

  		expect(reservation.reservation_overlap?).to eq false
  	end
  end

end
