class AddStatusToBatchFile < ActiveRecord::Migration[6.0]
  def change
    add_column :batch_files, :status, :string
  end
end
