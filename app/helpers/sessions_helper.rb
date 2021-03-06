module SessionsHelper
  # Sets the permanent cookie (20yr) taking as value the user remember
  # token, furthermore sets the current_user variable
  
	def sign_in_user(user,option = true)
    if option
      cookies.permanent[:remember_token] = user.remember_token
    else
      cookies[:remember_token] = user.remember_token
    end
      self.current_user = user
  end

  # Sets the current_user instance variable 

  def current_user=(user)
    @current_user = user
  end
  
  # Sets the @current_user instance variable to the user corresponding to the remember token,
  # but only if @current_user is undefined

  def current_user
  	@current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  # Checks if current_user is equal to the given user, and returns a boolean

  def current_user?(user)
    user == current_user
  end

  # Returns true if current users is not nil

  def signed_in?
    !current_user.nil? 
  end

  # Checks whether the user is authenticated, if not authenticated stores the requested URL(to redirect the user once logged in)
  # and performs the redirect to the login page showing a warning message.


  def signed_in_user 
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  end

  # Signout function sets the curent user to nil and deletes the cookie remeber_token

   def sign_out_user
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # Performs a redirect to an URL stored by the function store_location if it is defined, otherwise
  # its effect is to to redirect the user to the Url passed as parameter, after that deletes the stored URL

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # Stores a requested URL (useful for "Friendly Forwarding")

  def store_location
    session[:return_to] = request.url
  end
end
