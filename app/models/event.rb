class Event < ApplicationRecord
  belongs_to :organization
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  validates :organization, presence: true

  validates :date, presence: true
  validates :time, presence: true
  validates :event_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#"}, :default_url => '/system/events/eventsDefault.jpg'


  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validate :date, :expiration_date_cannot_be_in_the_past

  def to_s
    event_name
  end

  def address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  def address_changed?
    street_address_changed? || city_changed? || state_changed? || zip_code_changed?
  end

  def expiration_date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
