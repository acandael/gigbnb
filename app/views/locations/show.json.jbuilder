json.array!(@location.future_available_dates) do |date|
 json.start date.available_date
 json.rendering 'background'
end
