class User < ActiveRecord::Base
  belongs_to :group
  validates_length_of :username, :password, :minimum => 3, :too_short => "must be at least 3 characters."
  def validate        
    errors.add_to_base "Username not unique" if unique_username?
  end
  def unique_username?
    client_id = group.client_id
    i = false
    User.find_all_by_username(username).each do |u|
      if u.group.client_id == client_id
        i = true
      end
    end
    return i
  end
end