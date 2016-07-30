json.array!(@reservations) do |date|
 json.title "Reservation #{date.id}"
 json.start date.start_date + 15.hours
 json.end date.end_date + 11.hours
end
