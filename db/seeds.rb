address_options = [{city: "Gent", region: "Oost-Vlaanderen", postal_code: 9000, country: "BE"}, {city: "Blankenberge", region: "West-Vlaanderen", postal_code: 8370, country: "BE"}]

20.times do 
    address_option = address_options.sample
    location = Location.create(title: "lovely duplex", description: "lovely duplex in the centre of Brussels", beds: 2, guests: 3, price: 34.00)
    address = location.create_address(
      city: address_option[:city], 
      region: address_option[:region],
      postal_code: address_option[:postal_code],
      country: address_option[:country])
    address.geocode
    address.save
end

def add_available_dates(locations)
    locations.each do |location|
        today = Date.today

      (0..5).each do |n|
        day = today + n
        location.available_dates.create(available_date: day)
      end
    end
end

locations = Location.all
add_available_dates(locations)
