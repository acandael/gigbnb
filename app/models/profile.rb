class Profile < ActiveRecord::Base
  belongs_to :member

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :postal_code, numericality: true
  validates :cc_number, numericality: true

  has_attached_file :profile_pic,
    styles: { small: "100x100#" },
    default_url: "/images/:style/missing.png"
    validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\Z/
end
