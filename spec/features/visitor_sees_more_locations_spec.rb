require 'rails_helper'

feature "Visitor searches for locations" do

	before :all do
		FactoryGirl.create_list(:location_with_available_dates, 30)
		@first_location = Location.first
		@last_location = Location.last
	end

	scenario "by visiting index page with no search and clicks to view more" do
		visit locations_path
		expect(page).to have_content @first_location.title
		expect(page).not_to have_content @last_location.title
		click_link "Next"
		expect(page).to have_content @last_location.title
		expect(page).not_to have_content @first_location.title
	end

	scenario "by filling out form with certain dates and city and clicks to view more" do
		visit root_path
		expect(page).to have_content "Search for a location"
		fill_in "start_date", with: Date.tomorrow
		fill_in "end_date", with: Date.today + 2.days
		select "New York"
		select "NY"
		click_button "Search For Location"
		expect(page).to have_content @first_location.title
		expect(page).not_to have_content @last_location.title
		click_link "Next"
		expect(page).to have_content @last_location.title
		expect(page).not_to have_content @first_location.title
	end

end