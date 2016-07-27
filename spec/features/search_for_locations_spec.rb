require 'rails_helper'

feature "Visitor searches for locations to reserve" do

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
			zip: "27055")
	end

	scenario "Fills out form with certain dates and sees only matches" do
		visit root_path
		expect(page).to have_content "Search for a location"
		fill_in "start_date", with: Date.tomorrow
		fill_in "end_date", with: Date.today + 2.days
		click_button "Search For Location"

		expect(page).to have_content(@location1.address_1)
		expect(page).to have_content(@location2.address_1)
		expect(page).not_to have_content(@location3.address_1)
	end

	scenario "Fills out form with certain dates and city and sees only matches" do
		visit root_path
		expect(page).to have_content "Search for a location"
		fill_in "start_date", with: Date.tomorrow
		fill_in "end_date", with: Date.today + 2.days
		fill_in "city", with: "New York"
		fill_in "state", with: "NY"
		fill_in "country", with: "US"
		click_button "Search For Location"

		expect(page).to have_content(@location1.address_1)
		expect(page).to have_content(@location2.address_1)
		expect(page).not_to have_content(@location3.address_1)
		expect(page).not_to have_content(@location4.address_1)
	end

end