require "rails_helper"

describe LocationMatchesService do
  before do
    @location1 = FactoryGirl.create(:location_with_available_dates)
    @location2 = FactoryGirl.create(:location_with_available_dates,
      address_1: "43 E 19th St")
    @location3 = FactoryGirl.create(:location, address_1: "148 Chester Ave")
    @location4 = FactoryGirl.create(:location_with_available_dates, 
      address_1: "1029 Baltimore Rd",
      city: "Yadkinville",
      region: "NC", 
      country: "US",
      zip: "27055"
    )
  end

  describe "#matches" do
  	context "visitor searches with start date and end date" do
  		it "returns locations with available dates for the search dates" do
  			params = {start_date: Date.tomorrow.to_s, end_date: (Date.tomorrow + 2.days).to_s}
  			matches = LocationMatchesService.new(params).matches
        expect(matches.count).to eq 3
  			expect(matches.include?(@location1)).to eq true
        expect(matches.include?(@location2)).to eq true
        expect(matches.include?(@location4)).to eq true
  		end
  	end
    context "visitor searches with start date,end date, city, state, country" do
      it "returns locations with available dates for the search dates" do
        params = {start_date: Date.tomorrow.to_s, 
          end_date: (Date.tomorrow + 2.days).to_s,
          city: "New York",
          region: "NY",
          country: "US"
        }
        matches = LocationMatchesService.new(params).matches
        expect(matches.count(:all)).to eq 2
        expect(matches.include?(@location1)).to eq true
        expect(matches.include?(@location2)).to eq true
      end
    end
  end
end