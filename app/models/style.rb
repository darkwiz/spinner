class Style < ActiveRecord::Base
	attr_accessible :well_color, :background_color, :nav_inverse, :background_image
	belongs_to :user
end