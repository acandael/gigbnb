class Profile < ActiveRecord::Base
  belongs_to :member

  validates :first_name, presence: true
  validates :last_name, presence: true
end
