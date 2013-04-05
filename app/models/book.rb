class Book < ActiveRecord::Base
  attr_accessible :summary, :title
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 140 }
  validates :summary, length: { maximum: 2000 }
  validates :user_id, presence: true
  
  default_scope order: 'books.created_at DESC'
end
