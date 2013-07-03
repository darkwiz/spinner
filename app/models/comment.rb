class Comment < ActiveRecord::Base
   attr_accessible  :body, :author_id
   belongs_to :spin
   belongs_to :user
   validates :body, presence: true, length: { maximum: 140 }
   validates :spin_id, presence: true
end


