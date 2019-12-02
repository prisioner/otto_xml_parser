class Api::V1::ParcelsController < ApplicationController
  def index
    @parcels = Parcel.ordered

    render json: { data: @parcels }
  end

  def show

  end
end
