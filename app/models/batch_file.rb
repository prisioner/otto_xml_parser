class BatchFile < ApplicationRecord
  has_many :invoices
  has_one_attached :file
end
