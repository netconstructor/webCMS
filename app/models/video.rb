class Video < ActiveRecord::Base
  has_one :items, :as => :link
  accepts_nested_attributes_for :items, :allow_destroy => true
  before_save :edit_url
  def edit_url
    self.url = self.url.split('v=').last
    self.url = self.url.split('=').first
  end
end