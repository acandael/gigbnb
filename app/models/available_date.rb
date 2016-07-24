class AvailableDate < ActiveRecord::Base
  validates :available_date, presence: true
end
