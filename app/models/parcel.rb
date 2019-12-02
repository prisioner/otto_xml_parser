class Parcel < ApplicationRecord
  has_many :invoice_parcel_items

  scope :ordered, -> { order(created_at: :desc) }

  validates :code, uniqueness: true
end
