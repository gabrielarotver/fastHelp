class Organization < ApplicationRecord
  has_secure_password
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  has_many :events, dependent: :destroy

  validates :org_name, presence: true
  validates :org_type, presence: true
  validates :contact_name, presence: true
  validates :contact_number, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }, :default_url => '/system/organizations/banner.jpg'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def to_s
    "#{org_name}"
  end

  def address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  def address_changed?
    street_address_changed? || city_changed? || state_changed? || zip_code_changed?
  end

end
