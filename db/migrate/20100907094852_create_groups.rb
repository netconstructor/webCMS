class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :client_id
      t.string  :title
      t.boolean :admin, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
