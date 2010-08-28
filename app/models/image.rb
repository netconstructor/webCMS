class Image < ActiveRecord::Base
  belongs_to :gallery
  has_attached_file :data, 
                    :styles => {:small => ['135x135#', :jpg], :tsquare => ['100x100#', :jpg], :large => ['800x600>', :jpg]},
                    :default_style => :small,
                    :default_url => '/images/blank.gif',
                    :convert_options => {:thumb => '-strip -background white -flatten', :large => '-strip -background white -flatten'},
                    :path => ':rails_root/public/assets/photos/:id/:style.:extension',
                    :url =>                    '/assets/photos/:id/:style.:extension'

  validates_attachment_presence     :data
  validates_attachment_size         :data, :less_than => 5.megabytes
end