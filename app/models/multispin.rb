class Multispin < Spin
	attr_accessible :multimedia
	has_attached_file :multimedia, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

	def self.model_name
		Spin.model_name
	end

	def to_partial_path
		'spins/spin'
	end 
end