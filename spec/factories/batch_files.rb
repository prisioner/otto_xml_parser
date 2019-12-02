FactoryBot.define do
  factory :batch_file do
    after(:build) { |bf| bf.file.attach(io: File.open(Rails.root.join("spec", "fixtures", "sales_data.xml")), filename: "sales_data.xml") }
  end
end
