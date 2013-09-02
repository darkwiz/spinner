class Spin < ActiveRecord::Base
  attr_accessible :content, :as => [:default, :admin]
  belongs_to :user
  has_many :respins
  has_many :respinners, through: :respins, source: :respinner
  has_many :comments, dependent: :destroy
  has_many :reports, foreign_key: "reported_spin_id"
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
 
  
# Returns spins from the users being followed by the given user.
 def self.from_users_followed_by(user)
    followed_user_ids = user.followed_users.approved_relationships.pluck('users.id')
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user).select('spins.*, spins.created_at as last_respin_time')
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

 def self.multimedia_spins(user) 
   where('user_id = :user_id AND type = :spin_type',   
      user_id: user, spin_type: 'Multispin')
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

  # Allow Children To Use Their Parent’s Routes

  def self.inherited(child)
    child.instance_eval do
      def model_name
        Spin.model_name
      end
    end
    super
  end

  #Active Admin filter select
  def display_name
     "#{id}"
   end

end
