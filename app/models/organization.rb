class Organization < ApplicationRecord
  has_secure_password
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

  def to_s
    "#{org_name}"
  end
end
