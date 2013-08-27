module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.

  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def allowing?(user)
  	if user != current_user
  		 	object = user.private && !current_user.can_see?(@user) ? false : true 
  		 if object
  		    !user.private && user.blocking?(current_user) ? false : true
  		 end
  	else
  		true
  	end
  end

  # Sets navbar style based on user preferences

  def nav_inverse
    current_user.style.nav_inverse ? 'navbar-inverse' : ''
  end
end
