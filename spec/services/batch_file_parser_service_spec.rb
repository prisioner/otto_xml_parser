require "rails_helper"

RSpec.describe BatchFileParserService do
  describe ".call" do
    let(:batch_file_source) { Rails.root.join("spec", "fixtures", "sales_data.xml") }
    let(:batch_file) do
      file = BatchFile.new
      file.file.attach(io: File.open(batch_file_source), filename: "sales_data.xml")
      file.save

      file
    end

    context "everything is OK" do
      it "updates batch file in database" do
        expect { described_class.call(batch_file) }.to change(batch_file, :file_guid).from(nil).to("16BA036FCC3D4AF7E05378A06D0ADD38")
                                                         .and(change(batch_file, :batch_guid).from(nil).to("844986"))
                                                         .and(change(batch_file, :status).from("pending").to("success"))
      end

      it "creates data in database" do
        expect { described_class.call(batch_file) }.to change(Invoice, :count).by(2)
                                                         .and(change(Parcel, :count).by(3))
                                                         .and(change(InvoiceParcelItem, :count).by(3))
      end
    end

    context "file is damaged" do
      let(:batch_file_source) { Rails.root.join("spec", "fixtures", "damaged_sales_data.xml") }

      it "update status of batch file to error" do
        expect { described_class.call(batch_file) }.to change(batch_file, :status).from("pending").to("error")
      end

      it "doesn't update file guid of batch file" do
        expect { described_class.call(batch_file) }.not_to change(batch_file, :file_guid)
      end

      it "doesn't update batch guid of batch file" do
        expect { described_class.call(batch_file) }.not_to change(batch_file, :batch_guid)
      end

      it "doesn't create invoices in database" do
        expect { described_class.call(batch_file) }.not_to change(Invoice, :count)
      end

      it "doesn't create parcels in database" do
        expect { described_class.call(batch_file) }.not_to change(Parcel, :count)
      end

      it "doesn't create invoice parcel items in database" do
        expect { described_class.call(batch_file) }.not_to change(InvoiceParcelItem, :count)
      end
    end

    context "file is duplicate" do
      let(:batch_file2) do
        file = BatchFile.new
        file.file.attach(io: File.open(batch_file_source), filename: "sales_data.xml")
        file.save

        file
      end

      before(:each) { described_class.call(batch_file2) }

      it "change batch file status to duplicate" do
        expect { described_class.call(batch_file) }.to change(batch_file, :status).from("pending").to("duplicate")
      end

      it "doesn't update file guid of batch file" do
        expect { described_class.call(batch_file) }.not_to change(batch_file, :file_guid)
      end

      it "doesn't update batch guid of batch file" do
        expect { described_class.call(batch_file) }.not_to change(batch_file, :batch_guid)
      end

      it "doesn't create invoices in database" do
        expect { described_class.call(batch_file) }.not_to change(Invoice, :count)
      end

      it "doesn't create parcels in database" do
        expect { described_class.call(batch_file) }.not_to change(Parcel, :count)
      end

      it "doesn't create invoice parcel items in database" do
        expect { described_class.call(batch_file) }.not_to change(InvoiceParcelItem, :count)
      end
    end
  end
end
