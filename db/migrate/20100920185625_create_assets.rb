class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :folder_id
      t.string :data_file_name
      t.string :data_file_size
      t.string :data_updated_at
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
