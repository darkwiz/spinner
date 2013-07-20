class Respin < ActiveRecord::Base
  attr_accessible :respinner_id, :spin_id
  belongs_to :respinner, :class_name => "User"  # foreign key - respinner_id
  belongs_to :spin     # foreign key - spin_id

  validates :respinner_id, presence: true
  validates :spin_id, presence: true
 
 scope :by_respin_date, lambda { order('respins.created_at DESC') }

 def self.followed_respins_ids(user)
  followed_user_ids = user.followed_user_ids
     where("respinner_id IN (:followed_user_ids)", 
      followed_user_ids: followed_user_ids).pluck(:spin_id)
 end
end