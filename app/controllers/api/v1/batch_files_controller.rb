class Api::V1::BatchFilesController < ApplicationController
  def index
    @batch_files = BatchFile.all

    render json: { data: @batch_files }
  end

  def create
    @batch_file = BatchFile.new(batch_file_params)

    if @batch_file.save
      render json: { batch_file: @batch_file }
    else
      render json: { errors: @batch_file.errors.full_messages }, status: 422
    end
  end

  private

  def batch_file_params
    params.require(:batch_file).permit(:file)
  end
end
