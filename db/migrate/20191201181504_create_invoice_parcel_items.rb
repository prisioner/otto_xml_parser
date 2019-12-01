class CreateInvoiceParcelItems < ActiveRecord::Migration[6.0]
  def change
    create_table :invoice_parcel_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :parcel, null: false, foreign_key: true
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
