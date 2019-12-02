class InvoiceParcelItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :parcel

  def as_json(*)
    {
      id: id,
      parcel_code: parcel.code,
      invoice: invoice.operation_number,
      quantity: quantity,
      parcel_price: price,
    }
  end
end
