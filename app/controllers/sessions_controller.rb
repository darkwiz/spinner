class SessionsController < ApplicationController

  # Renders the signin module (sessions/new.html.erb)
	
  def new
	end

  # When the user attempts to log in, this method checks the submitted data, 
  # if there's a correspondence into the db it will authenticates the user,
  # otherwise the function notifies the user the error

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user.confirmed_user?
      sign_in_user(user, params[:remember_me])
      redirect_back_or user
    elsif user && user.authenticate(params[:session][:password])
      flash.now[:error] = 'Your account has not been activated yet, please check your email.'
      render 'new'
    else
     flash.now[:error] = 'Invalid email/password combination'
     render 'new'
   end
 end

  # When the user attempts to log out, this method recalls the sign_out method
  # and redirects the user to the signin/signup page

	def destroy
    sign_out_user
    redirect_to root_url
  end
end
