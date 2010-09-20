class Folder < ActiveRecord::Base
  belongs_to  :client
  has_many    :assets, :dependent => :delete_all
end