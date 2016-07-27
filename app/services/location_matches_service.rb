class LocationMatchesService 

	def initialize(params)
		@start_date = params[:start_date]
		@end_date = params[:end_date]		
		@city = params[:city]
		@region = params[:region]
		@country = params[:country]
	end

	def matches
		date_range_array = (@start_date.to_date..(@end_date.to_date - 1.day)).to_a
		near_locations = Location.near("#{@city}, #{@region}, #{@country}", 50)
		matches = near_locations.joins(:available_dates).where(
			available_dates: {available_date: date_range_array }).uniq
		matches
	end

end