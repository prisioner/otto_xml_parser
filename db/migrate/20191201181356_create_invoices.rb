class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :operation_number
      t.string :operation_date
      t.string :company_code
      t.references :batch_file, null: false, foreign_key: true

      t.timestamps

      t.index :operation_number, unique: true
    end
  end
end
