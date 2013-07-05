class ApplicationController < ActionController::Base
  protect_from_forgery
  # Makes session helpers available in all controllers
  # by default, all the helpers are available from the views but not from the controllers.
  
  include SessionsHelper  

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
 
end
