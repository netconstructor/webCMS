class Gallery < ActiveRecord::Base
  belongs_to  :client
  has_many    :items, :as => :link
  has_many    :images, :dependent => :delete_all
  accepts_nested_attributes_for :images, :allow_destroy => true
end