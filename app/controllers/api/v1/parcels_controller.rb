class Api::V1::ParcelsController < ApplicationController
  def index
    @parcels = Parcel.ordered

    render json: { data: @parcels }
  end

  def show
    @parcel = Parcel.find_by!(code: params[:id])
    @parcel_items = @parcel.invoice_parcel_items

    render json: { parcel: @parcel, parcel_items: @parcel_items }
  end
end
