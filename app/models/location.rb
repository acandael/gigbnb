class Location < ActiveRecord::Base
  belongs_to :member


  has_many :location_images, dependent: :destroy
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address, :location_images, allow_destroy: true

  validates :title, presence: true
  validates :beds, numericality: true
  validates :guests, numericality: true
  validates :price, numericality: true
end
