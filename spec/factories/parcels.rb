FactoryBot.define do
  factory :parcel do
    sequence(:code) { |n| n.to_s.rjust(7, "0") }
  end
end
