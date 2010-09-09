class Image < ActiveRecord::Base
  belongs_to :gallery
  acts_as_list :scope => :gallery_id, :order => :position
  default_scope :order => :position

  has_attached_file :data, 
                    :styles => {:small => ['155x145#', :jpg], :tsquare => ['100x100#', :jpg], :large => ['800x600>', :jpg], :slideshow => ['500x250#']},
                    :default_style => :small,
                    :default_url => '/images/blank.gif',
                    :convert_options => {:thumb => '-strip -background white -flatten', :large => '-strip -background white -flatten'},
                    :path => ':rails_root/public/assets/photos/:id/:style.:extension',
                    :url =>                    '/assets/photos/:id/:style.:extension'

  validates_attachment_presence     :data
  validates_attachment_size         :data, :less_than => 5.megabytes
end