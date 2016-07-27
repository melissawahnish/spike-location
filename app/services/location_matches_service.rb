class LocationMatchesService 

	def initialize(params)
		@start_date = params[:start_date]
		@end_date = params[:end_date]		
	end

	def matches
		date_range_array = (@start_date.to_date..(@end_date.to_date - 1.day)).to_a
		Location.joins(:available_dates).where(
			available_dates: {available_date: date_range_array }).uniq
	end

end