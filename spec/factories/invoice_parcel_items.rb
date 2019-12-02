FactoryBot.define do
  factory :invoice_parcel_item do
    association :invoice
    association :parcel

    price { 9999 }
    quantity { 4 }
  end
end
