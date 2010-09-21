class AddCodeToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :code, :string
  end

  def self.down
    remove_column :clients, :code
  end
end
