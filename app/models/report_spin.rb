class ReportSpin < Report
	attr_accessible :reported_spin_id
	belongs_to :spin, :foreign_key => "reported_spin_id"
	validates :user_id, presence: true
	validates :reported_spin_id, presence: true
end