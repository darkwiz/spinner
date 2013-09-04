class ReportComment < Report
	attr_accessible :reported_comment_id
	belongs_to :comment, :foreign_key => "reported_comment_id"
	validates :user_id, presence: true
	validates :reported_comment_id, presence: true
end