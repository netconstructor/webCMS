class Gallery < ActiveRecord::Base
  has_many :images, :dependent => :delete_all
end
