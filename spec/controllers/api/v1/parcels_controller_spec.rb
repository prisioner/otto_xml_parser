require "rails_helper"

RSpec.describe Api::V1::ParcelsController, type: :controller do
  let(:parsed_response) { JSON.parse(response.body).symbolize_keys }
  let!(:parcels) { create_list(:parcel, 3) }
  let(:parcel) { parcels.first }
  let!(:parcel_items) { create_list(:invoice_parcel_item, 3, parcel: parcel) }

  describe "GET #index" do
    it "returns all parcels" do
      get :index

      data = parsed_response.fetch(:data)

      expect(data).to contain_exactly(*parcels.map(&:as_json))
    end
  end

  describe "GET #show" do
    context "valid parcel code provided" do
      it "returns parcel with parcel items" do
        get :show, params: { id: parcel.code }

        expect(parsed_response.fetch(:parcel).fetch("code")).to eq parcel.code
        expect(parsed_response.fetch(:parcel_items)).to contain_exactly(*parcel_items.map(&:as_json))
      end
    end

    context "invalid parcel code provided" do
      it "returns 404 error" do
        get :show, params: { id: "asdf" }

        expect(response.code).to eq "404"
        expect(parsed_response[:error]).to eq "Not Found"
      end
    end
  end
end
