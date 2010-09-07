class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships, :id => false do |t|
        t.integer :group_id, :null => false
        t.integer :page_id,  :null => false
    end
  end

  def self.down
    drop_table :memberships
  end
end
