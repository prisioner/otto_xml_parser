class Api::V1::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.ordered

    render json: { data: @invoices }
  end

  def show

  end
end
