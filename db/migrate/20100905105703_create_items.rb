class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :page_id
      t.integer :part_id
      t.integer :position
      t.integer :link_id
      t.string  :link_type
      t.string  :title
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
