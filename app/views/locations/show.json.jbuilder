json.array!(@location.future_available_dates) do |date|
	json.id date.id
  json.start date.available_date 
  json.rendering 'background'
end
