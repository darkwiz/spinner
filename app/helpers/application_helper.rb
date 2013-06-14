module ApplicationHelper
	def full_title(page_title)
		base_title = 'Loop App'
		if page_title.empty?
			base_title
		else 
			"#{base_title} | #{page_title}"
		end
	end

	def body_class
		current_page?('/') ? "homepage" : "no_homepage"
	end
end
