class Reservation < ActiveRecord::Base
	belongs_to :location

	validate :dates_are_available

	def dates_are_available
	  if !confirm_available_dates
	    errors[:base] << "Some of the dates of your reservation are not 
	    available.  Please try different dates."
	  end
	end


	def confirm_available_dates
		reservation_array =  (start_date..end_date).to_a
		available_dates = AvailableDate.where(location_id: location.id).where(available_date: reservation_array)
		non_reserved_available_dates = available_dates.where(reserved: false)
		non_reserved_available_dates.count == reservation_array.count
	end

end
