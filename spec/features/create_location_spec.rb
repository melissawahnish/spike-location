require 'rails_helper'

feature "Member creates location" do
  
  scenario "by entering a description and uploading images" do
    visit new_location_path
    expect(page).to have_content("New Location")
		fill_in "location[description]", with: Faker::Lorem.paragraph(2)
	
    click_button "Create Location"
    expect(page).to have_content("Location was successfully created.")
    
    expect(page).to have_content "Add Images"
  
		picture_1_path = 'spec/fixtures/files/picture_1.jpg' 

		attach_file "location[location_images_attributes][0][picture]", picture_1_path
		click_button "UPDATE & SAVE"

		expect(LocationImage.count).to eq 1
		expect(LocationImage.first.picture_order).to eq 1

  end

end
