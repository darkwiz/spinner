class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :username, :confirmed_user, :private, :as => [:default, :admin] #:password_confirmation da eliminare
  attr_accessible :banned , :as => :admin # devise allows admin mass-assignment
  attr_accessor :updating_password  

  has_secure_password
  has_many :spins, dependent: :destroy # spins should be destroyed along with the user
  has_many :respins, foreign_key: "respinner_id"
  has_many :respinned_spins, through: :respins, source: :spin
  has_many :comments, dependent: :destroy # comments should be destroyed along with the user
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy  
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_and_belongs_to_many :blocked_users, :class_name => "User", :join_table => "blacklisted_users", :foreign_key => "blocker_id"
  has_many :reports, foreign_key: "reported_user_id"
  has_many :reports
  has_one :style
  before_create :build_default_style
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token


  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username, uniqueness: true, presence: true 
  validates :password, presence: true, length: { minimum: 6 }, :if => :should_validate_password?
  validates :password_confirmation, presence: true, :if => :should_validate_password?

  scope :pending_requests, lambda { Relationship.pending }
  scope :approved_relationships, lambda { Relationship.approved }
  #scope :public, -> { where( private: false ) }


  def should_validate_password?
    updating_password || new_record?
  end

  def send_password_reset 
       generate_token(:password_reset_token)
       self.password_reset_sent_at = Time.zone.now
       self.updating_password = false
       save!
       UserMailer.password_reset(self).deliver
  end

  def send_confirm_email
       generate_token(:user_confirm_token)
       self.user_confirm_sent_at = Time.zone.now
       #self.updating_password = false
       save!
       UserMailer.user_confirmation(self).deliver
  end
  
  def timeline
      (Spin.from_users_followed_by(self) + Spin.respinned_by_followed(self))
  end
 
  def personal_spins
     Spin.user_spins(self) + Spin.user_respins(self)
  end

   def user_multimedia
     Spin.multimedia_spins(self)
   end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    if other_user.private
      relationships.create!(followed_id: other_user.id, approved: false)
    else
      relationships.create!(followed_id: other_user.id)
    end
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def reject!(other_user)
     reverse_relationships.find_by_follower_id(other_user.id).destroy
  end

  def can_see?(other_user)
    begin
      relationships.find_by_followed_id(other_user.id).approved
    rescue => e
      logger.warn "Unable to find record: #{e}"
      false
    end
  end

  def block!(other_user)
      blocked_users << other_user
  end

  def remove_block!(other_user)
      blocked_users.delete(other_user)
  end
  
  def blocking?(other_user)
    blocked_users.exists?(other_user)
  end

  def self.search(query)
  if query.blank?
      scoped
    else
      q = "%#{query}%"
      where("username like ?", q)
  end
end

  
private
  
  def generate_token(column)
   begin
    self[column] = SecureRandom.urlsafe_base64
   end while User.exists?(column => self[column])
  end
  
  # Create a token for for persistent login.

  def create_remember_token
     self.remember_token = SecureRandom.urlsafe_base64
  end

  def build_default_style
  # build default style instance. Will use default params.
  # The foreign key to the owning User model is set automatically
  build_style
  true # Always return true in callbacks as the normal 'continue' state
       # Assumes that the default_profile can **always** be created.
       # or
       # Check the validation of the style. If it is not valid, then
       # return false from the callback. Best to use a before_validation 
       # if doing this. View code should check the errors of the child.
       # Or add the child's errors to the User model's error array of the :base
       # error item
end

end
