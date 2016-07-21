json.array!(@location.future_reserved_dates) do |date|
  json.start date.start_date
  json.end date.end_date  
  json.rendering 'background'
end
