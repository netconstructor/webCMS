class Gallery < ActiveRecord::Base
  belongs_to  :client
  has_many    :images, :dependent => :delete_all
end
