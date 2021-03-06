class ReportUser < Report
	attr_accessible :reported_user_id
	belongs_to :user, :foreign_key => "reported_user_id" 
	belongs_to :reported_by, :class_name => "User", :foreign_key => "user_id" 
	validates :user_id, presence: true
	validates :reported_user_id, presence: true
end