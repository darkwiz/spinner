module ApplicationHelper

	# Provides the title for every page

	def full_title(page_title)
		base_title = 'Spin'
		if page_title.empty?
			base_title
		else 
			"#{base_title} | #{page_title}"
		end
	end

    # Sets the body "class" attribute in order to differentiate the backgrounds
    
	def body_class
		!signed_in? && current_page?('/') ? "homepage" : "no_homepage"
	end

end
