require "rails_helper"

describe LocationMatchesService do

  describe "#matches" do
  	context "visitor searches with start date and end date" do
  		it "returns locations with available dates for the search dates" do
  			location1 = FactoryGirl.create(:location_with_available_dates)
  			location2 = FactoryGirl.create(:location_with_available_dates,
					address_1: "43 E 19th St")
  			location3 = FactoryGirl.create(:location, address_1: "148 Chester Ave")
  			params = {start_date: Date.tomorrow.to_s, end_date: (Date.tomorrow + 2.days).to_s}
  			matches = LocationMatchesService.new(params).matches
  			expect(matches).to eq [location1, location2]
  		end
  	end
  end
end