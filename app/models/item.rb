class Item < ActiveRecord::Base
  belongs_to :link, :polymorphic => true
  accepts_nested_attributes_for :link
  belongs_to :page
  has_many :parts
  def article=(article)
    self.link = Article.new(article)
  end
end
