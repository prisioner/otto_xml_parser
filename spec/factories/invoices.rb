FactoryBot.define do
  factory :invoice do
    association :batch_file

    company_code { "1234" }
    operation_date { "25.10.2019" }
    sequence(:operation_number) { |n| n.to_s.rjust(15, "0") }
  end
end
