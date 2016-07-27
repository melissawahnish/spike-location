class Reservation < ActiveRecord::Base
	belongs_to :location

	validate :dates_are_available

	def dates_are_available
	  if reservation_overlap? || dates_unavailable?
	    errors[:base] << "Some of the dates of your reservation are not 
	    available.  Please try different dates."
	  end
	end

	def reservation_overlap?
	  start_date_overlap = location.reservations.where(start_date: 
	    start_date..end_date - 1.day)
	  end_date_overlap = location.reservations.where(end_date:  
	    start_date..end_date - 1.day)
	  start_date_overlap.exists? || end_date_overlap.exists?
	end


	def dates_unavailable?
		reservation_array =  (start_date..end_date).to_a
		available_dates = AvailableDate.where(location_id: location.id).where(available_date: reservation_array)
		non_reserved_available_dates = available_dates.where(reserved: false)
		non_reserved_available_dates.count != reservation_array.count
	end

end
