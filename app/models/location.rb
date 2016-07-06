class Location < ActiveRecord::Base
	has_many :location_images
	accepts_nested_attributes_for :location_images, allow_destroy: true
end
