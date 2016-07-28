class AvailableDate < ActiveRecord::Base
  belongs_to :location
  validates :available_date, presence: true
end
