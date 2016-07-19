class Location < ActiveRecord::Base
	has_many :location_images
	has_many :available_dates
	has_many :reservations

	accepts_nested_attributes_for :location_images, allow_destroy: true

	geocoded_by :full_street_address   
	after_validation :geocode, if: ->(obj){ obj.address_1.present? and obj.address_changed? } 

	def full_street_address
		[address_1, city, region, country].compact.join(", ")
	end

	def address_changed?
		address_1_changed? || city_changed? || region_changed? || country_changed?
	end

	def future_reserved_dates
	  self.reservations.where("end_date >= ?", Date.today)
	end

end
