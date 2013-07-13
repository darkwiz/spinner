class Spin < ActiveRecord::Base
  attr_accessible :content, :in_reply_to
  belongs_to :user
  has_many :respins
  has_many :respinners, through: :respins, source: :respinner
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope order('spins.created_at DESC')


# Returns spins from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user)
  end

 def self.including_replies(user)
  	where("in_reply_to = ?", user.username) 
 end

 def self.spins_respins(user)
     respinned_spin_ids = user.respinned_spin_ids
     where("id IN (:respinned_spin_ids) OR user_id = :user_id", 
      respinned_spin_ids: user.respinned_spin_ids, user_id: user)
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
