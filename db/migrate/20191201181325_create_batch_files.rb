class CreateBatchFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :batch_files do |t|
      t.string :file_guid
      t.string :batch_guid

      t.timestamps

      t.index :file_guid, unique: true
      t.index :batch_guid, unique: true
    end
  end
end
