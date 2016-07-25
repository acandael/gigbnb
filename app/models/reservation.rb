class Reservation < ActiveRecord::Base
  belongs_to :location
  belongs_to :member
  validate :dates_are_available

  def dates_are_available
    start_date_overlap = location.reservations.where(start_date:
    start_date..end_date - 1.day)
    end_date_overlap = location.reservations.where(end_date:
    start_date..end_date - 1.day)
    if start_date_overlap.exists? || end_date_overlap.exists?
      errors[:base] << "Some of the dates of your reservation are not
      available. Please try different dates."
    end
  end
end
