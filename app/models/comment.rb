class Comment < ActiveRecord::Base
   attr_accessible :body
   belongs_to :spin
   belongs_to :user
   has_many :reports, foreign_key: "reported_comment_id", dependent: :destroy
   validates :body, presence: true, length: { maximum: 140 }
   validates :spin_id, presence: true

  # Active Admin filter workaround for select
   def display_name
     "#{id}"
   end
end


