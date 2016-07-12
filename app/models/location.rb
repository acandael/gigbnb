class Location < ActiveRecord::Base
  belongs_to :member

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  has_many :location_images, dependent: :destroy
  has_one :address
  accepts_nested_attributes_for :address, :location_images, allow_destroy: true

  validates :title, presence: true
  validates :beds, numericality: true
  validates :guests, numericality: true
  validates :price, numericality: true
end
