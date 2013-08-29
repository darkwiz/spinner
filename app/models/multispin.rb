class Multispin < Spin
	attr_accessible :multimedia
	has_attached_file :multimedia, :styles => { :medium => "300x300#", :thumb => "100x100#", :big => "500x500#" }, :default_url => "/images/:style/missing.png"
	validates_attachment_presence :multimedia

	validates_attachment_content_type :multimedia, 
                                    :content_type => /^image\/(png|gif|jpeg|jpg)/
  		
	# def self.model_name
	# 	Spin.model_name
	# end

	def to_partial_path
		'spins/spin'
	end 
end