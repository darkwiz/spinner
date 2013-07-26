class Spin < ActiveRecord::Base
  attr_accessible :content, :in_reply_to
  belongs_to :user
  has_many :respins
  has_many :respinners, through: :respins, source: :respinner
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
 
  
# Returns spins from the users being followed by the given user.
 def self.from_users_followed_by(user)
    followed_user_ids = user.followed_users.approved_relationships.pluck('users.id')
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user).select('spins.*, spins.created_at as last_respin_time')
 end

 def self.including_replies(user)
  	where("in_reply_to = ?", user.username).select('spins.*, spins.created_at as last_respin_time')
 end

 def self.respinned_by_followed(user)
     followed_user_ids = user.followed_users.approved_relationships.pluck('users.id')
     joins(:respins).where("respinner_id IN (:followed_user_ids)",   
      followed_user_ids: followed_user_ids).select('spins.*, respins.created_at as last_respin_time, respins.respinner_id as respinner_id, respins.id as respin_id')
 end

 def self.user_spins(user)
     where("user_id = :user_id", 
       user_id: user).select('spins.*, spins.created_at as last_respin_time')
 end

 def self.user_respins(user) 
   joins(:respins).where("respinner_id = :user_id",   
      user_id: user).select('spins.*, respins.created_at as last_respin_time')
 end

 def respin!(user)
    respins.create!(respinner_id: user.id)
 end

 def cancel_respin!(user)
    respins.find_by_respinner_id(user.id).destroy
  end

  def respinned?(user)
    respins.find_by_respinner_id(user.id)
  end

=begin
 def self.including_respins(user)
     followed_user_ids = user.followed_user_ids
     respinned_spin_ids = user.respinned_spin_ids
     where("user_id IN (:followed_user_ids) AND id = :id ",
          followed_user_ids: followed_user_ids, id: respinned_spin_ids)
 end 
=end

end
