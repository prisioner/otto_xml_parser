require "rails_helper"

RSpec.describe Api::V1::BatchFilesController, type: :controller do
  let(:parsed_response) { JSON.parse(response.body).symbolize_keys }
  let!(:batch_files) { create_list(:batch_file, 3) }
  let(:file) { fixture_file_upload("sales_data.xml", "text/xml") }

  describe "GET #index" do
    it "returns all batch_files" do
      get :index

      data = parsed_response.fetch(:data)

      expect(data).to contain_exactly(*batch_files.map(&:as_json))
    end
  end

  describe "POST #create" do
    it "add file entry to database" do
      expect { post :create, params: { batch_file: { file: file } } }.to change(BatchFile, :count).by(1)
    end

    it "enqueue parse job" do
      expect { post :create, params: { batch_file: { file: file } } }.to have_enqueued_job(BatchFileParseJob)
    end
  end
end
