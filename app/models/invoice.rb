class Invoice < ApplicationRecord
  belongs_to :batch_file
  has_many :invoice_parcel_items

  scope :ordered, -> { order(created_at: :desc) }

  validates :operation_number, uniqueness: true
end
