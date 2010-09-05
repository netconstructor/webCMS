class Gallery < ActiveRecord::Base
  belongs_to  :client
  has_many    :items, :as => :link
  has_many    :images, :dependent => :delete_all
end