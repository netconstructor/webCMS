class Image < ActiveRecord::Migration
  def self.up
    add_column :images, :name, :string
  end

  def self.down
    remove_column :images, :name
  end
end
