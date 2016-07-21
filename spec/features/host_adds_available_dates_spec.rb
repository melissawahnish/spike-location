require 'rails_helper'

feature "Host adds available dates to a location" do
	let(:location) {FactoryGirl.create(:location)}

	scenario "by adding dates to a form" do
		visit calendar_location_path(location)
		expect(page).to have_content "Add Available Dates"

		fill_in "start_date", with: Date.tomorrow
		fill_in "end_date", with: Date.today + 2.days
		click_button "Add available dates"
		expect(page).to have_content "Successfully added available dates"

		expect(AvailableDate.count).to eq 2
		available_date = AvailableDate.last
		expect(available_date.location_id).to eq location.id
		expect(available_date.available_date).to eq Date.today + 2.days
		expect(available_date.reserved).to eq false
	end

	scenario "by adding dates but not creating duplicates" do
		AvailableDate.create(available_date: Date.tomorrow, location_id: location.id)

		visit calendar_location_path(location)
		expect(page).to have_content "Add Available Dates"

		fill_in "start_date", with: Date.tomorrow
		fill_in "end_date", with: Date.today + 2.days
		click_button "Add available dates"
		expect(page).to have_content "Successfully added available dates"

		expect(AvailableDate.count).to eq 2
		available_date = AvailableDate.last
		expect(available_date.location_id).to eq location.id
		expect(available_date.available_date).to eq Date.today + 2.days
		expect(available_date.reserved).to eq false

	end

end