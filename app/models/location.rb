class Location < ActiveRecord::Base
  belongs_to :member

  validates :title, presence: true
  validates :postal_code, numericality: true
  validates :beds, numericality: true
  validates :guests, numericality: true
  validates :price, numericality: true

  def country_name(country_code)
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end
end
