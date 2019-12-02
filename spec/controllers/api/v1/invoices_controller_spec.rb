require "rails_helper"

RSpec.describe Api::V1::InvoicesController, type: :controller do
  let(:parsed_response) { JSON.parse(response.body).symbolize_keys }
  let!(:invoices) { create_list(:invoice, 3) }
  let(:invoice) { invoices.first }
  let!(:parcel_items) { create_list(:invoice_parcel_item, 3, invoice: invoice) }

  describe "GET #index" do
    it "returns all invoices" do
      get :index

      data = parsed_response.fetch(:data)

      expect(data).to contain_exactly(*invoices.map(&:as_json))
    end
  end

  describe "GET #show" do
    context "valid invoice operation number provided" do
      it "returns invoice with parcel items" do
        get :show, params: { id: invoice.operation_number }

        expect(parsed_response.fetch(:invoice).fetch("operation_number")).to eq invoice.operation_number
        expect(parsed_response.fetch(:parcel_items)).to contain_exactly(*parcel_items.map(&:as_json))
      end
    end

    context "invalid invoice operation number provided" do
      it "returns 404 error" do
        get :show, params: { id: "asdf" }

        expect(response.code).to eq "404"
        expect(parsed_response[:error]).to eq "Not Found"
      end
    end
  end
end
