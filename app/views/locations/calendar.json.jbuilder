json.array!(@location.reservations) do |date|
 json.title "Reservation #{date.id}"
 json.start date.start_date + 15.hours
 json.end date.end_date + 11.hours
end
 
json.array!(@location.future_available_dates) do |date|
 json.start date.available_date
 json.rendering "background"
 json.backgroundColor "green"
end
