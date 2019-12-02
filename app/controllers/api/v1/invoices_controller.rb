class Api::V1::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.ordered

    render json: { data: @invoices }
  end

  def show
    @invoice = Invoice.find_by!(operation_number: params[:id])
    @parcel_items = @invoice.invoice_parcel_items

    render json: { invoice: @invoice, parcel_items: @parcel_items }
  end
end
