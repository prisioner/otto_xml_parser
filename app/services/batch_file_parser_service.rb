class BatchFileParserService
  def self.call(batch_file)
    new(batch_file).call
  end

  def initialize(batch_file)
    @batch_file = batch_file
  end

  def call
    ActiveRecord::Base.transaction do
      file_guid = data.fetch(:FileAttribute).fetch(:GUID)
      file_data = data.fetch(:FileData)
      batch_guid = file_data.fetch(:Batch).fetch(:BatchID)

      @batch_file.update!(file_guid: file_guid, batch_guid: batch_guid, status: :success)

      invoices = arrify(file_data.fetch(:Invoice))

      create_invoices!(invoices)
    end

  rescue ActiveRecord::RecordNotUnique
    @batch_file.reload.update!(status: :duplicate)
  rescue
    @batch_file.reload.update!(status: :error)
  end

  def data
    @data ||= Ox.load(File.read(@batch_file.filepath), mode: :hash)[:Root]
  end

  private

  def create_invoices!(invoices_data)
    invoices_data.each do |invoice|
      operation = invoice.fetch(:InvoiceOperation)

      invoice_object = Invoice.create!(invoice_params(operation))

      invoice_data = arrify(invoice.fetch(:InvoiceData))

      invoice_data.each do |invoice_parcel|
        InvoiceParcelItem.create!(
          invoice_parcel_item_params(invoice_parcel, invoice_object)
        )
      end
    end
  end

  def invoice_params(invoice_data)
    {
      batch_file:       @batch_file,
      company_code:     invoice_data.fetch(:CompanyCode),
      operation_number: invoice_data.fetch(:InvoiceOperationNumber),
      operation_date:   invoice_data.fetch(:InvoiceOperationDate),
    }
  end

  def invoice_parcel_item_params(invoice_parcel_data, invoice)
    {
      invoice:  invoice,
      parcel:   Parcel.find_or_create_by(code: invoice_parcel_data.fetch(:ParcelCode)),
      quantity: invoice_parcel_data.fetch(:ItemQty),
      price:    invoice_parcel_data.fetch(:ParcelPrice),
    }
  end

  def arrify(smth)
    smth.is_a?(Array) ? smth : [smth]
  end
end
