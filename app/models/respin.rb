class Respin < ActiveRecord::Base
  attr_accessible :respinner_id, :spin_id
  belongs_to :respinner, :class_name => "User"  # foreign key - respinner_id
  belongs_to :spin     # foreign key - spin_id

  validates :respinner_id, presence: true
  validates :spin_id, presence: true
end