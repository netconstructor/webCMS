class Item < ActiveRecord::Base
  before_destroy :delete_association
  belongs_to :link, :polymorphic => true
  accepts_nested_attributes_for :link
  belongs_to :page
  has_many :parts
  acts_as_list :scope => 'page_id = #{page_id} AND part_id = #{part_id}', :order => :position
  default_scope :order => :position
  
  def article=(article)
    self.link = Article.new(article)
  end
  def video=(video)
    self.link = Video.new(video)
  end
  
private
  def delete_association
    types = ['article', 'video']
    if types.include?(link_type.to_s.downcase)
      i = link
      i.delete
    end
  end
end