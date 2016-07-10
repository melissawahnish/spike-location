require 'rails_helper'

feature "Member creates location" do
  
  scenario "by entering a description and uploading images" do
    visit new_location_path
    expect(page).to have_content("New Location")
		fill_in "location[description]", with: Faker::Lorem.paragraph(2)
		fill_in "location[address_1]", with: "350 5th Ave"
		fill_in "location[address_2]", with: "Suite 300"
		fill_in "location[city]", with: "New York"
		fill_in "location[region]", with: "NY"
		fill_in "location[zip]", with: "10118"
		fill_in "location[country]", with: "US"

    click_button "Create Location"

    location = Location.last
    expect(location).to_not have_attributes(
    	longitude: nil, latitude: nil, 
    	description: nil, address_1: nil
    )

    expect(page).to have_content("Location was successfully created.")
    expect(page).to have_content "Add Images"
  
		picture_1_path = 'spec/fixtures/files/picture_1.jpg' 

		attach_file "location[location_images_attributes][0][picture]", picture_1_path
		click_button "UPDATE & SAVE"

		expect(LocationImage.count).to eq 1
		expect(LocationImage.first.picture_order).to eq 1

  end

end
