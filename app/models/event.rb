class Event < ApplicationRecord
  belongs_to :organization

  validates :organization, presence: true

  validates :date, presence: true
  validates :time, presence: true
  validates :event_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  def to_s
    event_name
  end
end
