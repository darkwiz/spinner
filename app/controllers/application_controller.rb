class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper  # Makes session helpers available in all controllers
  						  # By default, all the helpers are available in the views but not in the controllers.
  						  # Include tag Makes it available into controllers
  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
 
end
