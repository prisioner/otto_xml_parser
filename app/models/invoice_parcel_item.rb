class InvoiceParcelItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :parcel
end
