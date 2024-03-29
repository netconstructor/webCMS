class Article < ActiveRecord::Base
  has_one :items, :as => :link, :dependent => :destroy
  accepts_nested_attributes_for :items, :allow_destroy => true
end