class Page < ActiveRecord::Base
  belongs_to :client
  has_many :items
  acts_as_list  :scope => :parent_id
  acts_as_tree  :order => "position"
  default_scope :order => :position
end
