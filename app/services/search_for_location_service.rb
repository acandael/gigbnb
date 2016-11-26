class SearchForLocationService
  attr_reader :params

  def initialize(params)
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @city = params[:city]
    @region = params[:region]
  end

 def matches
  unless @start_date.blank? | @end_date.blank?
    date_range_array = (@start_date.to_date..
    (@end_date.to_date - 1.day)).to_a
  end
  unless @city.blank? && @region.blank?
    address = "#{@city}, #{@region}"
  end
  Location.nearby(address).with_available_dates(date_range_array).uniq
 end
end
