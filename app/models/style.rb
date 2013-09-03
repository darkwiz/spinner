class Style < ActiveRecord::Base
	attr_accessible :well_color, :background_color, :nav_inverse, :background_image
	belongs_to :user
	validates :user_id, presence: true
	VALID_HEX_REGEX = /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
  	validates :well_color, presence:   true,
                    format:  { with: VALID_HEX_REGEX }
    validates :background_color, presence:   true,
                    format:  { with: VALID_HEX_REGEX }
end