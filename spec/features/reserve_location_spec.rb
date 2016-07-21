require 'rails_helper'

feature "Member reserves location" do
	let(:location) {FactoryGirl.create(:location_with_available_dates)}

	scenario "by visiting location show page and selecting available dates" do
		visit location_path(location)
		expect(page).to have_content location.description

		fill_in "reservation[start_date]", with: Date.tomorrow
		fill_in "reservation[end_date]", with: Date.today + 2.days

		click_button "Reserve Location"

		expect(page).to have_content "Reservation successfully created."

		expect(Reservation.count).to eq 1
		reservation = Reservation.last
		expect(reservation.location_id).to eq location.id
		expect(reservation.start_date).to eq Date.tomorrow
		expect(reservation.end_date).to eq Date.today + 2.days
	end

	scenario "and receives error message if not reserving available dates" do
		visit location_path(location)
		expect(page).to have_content location.description

		fill_in "reservation[start_date]", with: Date.today + 3.days
		fill_in "reservation[end_date]", with: Date.today + 5.days

		click_button "Reserve Location"

		expect(page).to have_content "Some of the dates of your reservation are not 
	    available.  Please try different dates."

		expect(Reservation.count).to eq 0
	end
end