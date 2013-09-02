class Comment < ActiveRecord::Base
   attr_accessible :body
   belongs_to :spin
   belongs_to :user
   has_many :reports, foreign_key: "reported_comment_id"
   validates :body, presence: true, length: { maximum: 140 }
   validates :spin_id, presence: true

  #Active Admin filter workaround for select (breaks view action into admin?)
   def display_name
     "#{id}"
   end
end


