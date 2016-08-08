class AvailableDate < ActiveRecord::Base
  belongs_to :location
  validates :available_date, presence: true

  scope :upcoming, -> { where("available_date >= ?", Date.today) }
  scope :unreserved, -> { where(reserved: false) }
  scope :available_for_reservation, ->(date_range_array) {
     upcoming.unreserved.where(available_date: date_range_array) if date_range_array.present?
  }
end
