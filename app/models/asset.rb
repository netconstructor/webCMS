class Asset < ActiveRecord::Base
  belongs_to :folder
  acts_as_list :scope => :folder_id, :order => :position
  default_scope :order => :position

  has_attached_file :data,
    :path => ':rails_root/public/assets/files/:id/:style.:extension',
    :url =>                    '/assets/files/:id/:style.:extension'

  validates_attachment_presence     :data unless :data
  validates_attachment_size         :data, :less_than => 10.megabytes unless :data
end
