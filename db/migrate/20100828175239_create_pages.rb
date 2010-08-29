class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :client_id
      t.integer :parent_id
      t.integer :position
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
