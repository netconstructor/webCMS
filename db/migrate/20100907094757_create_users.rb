class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :group_id
      t.string :username
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
