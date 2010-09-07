class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :pages, :through => :memberships
  belongs_to :client
end