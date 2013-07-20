class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :username, :confirmed_user
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
      (Spin.from_users_followed_by(self) + Spin.including_replies(self)).uniq + Spin.respinned_by_followed(self) 
  end
 
  def user_spins
     Spin.user_spins(self) + Spin.user_respins(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def self.search(search)
    if search
      where("name LIKE ?", "%#{search}%") 
      #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
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

end
