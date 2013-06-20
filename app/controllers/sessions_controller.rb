class SessionsController < ApplicationController

  # Renders the signin module (sessions/new.html.erb)
	
  def new
	end

  # When the user attempts to log in, this method checks the submitted data, 
  # if there's a correspondence into the db it will authenticates the user,
  # otherwise the function notifies the user the error

	def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if params[:remember_me]
      sign_in user
    else
      sign_in(user, false)
    end

      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
     end
    end

  # When the user attempts to log out, this method recalls the sign_out method
  # and redirects the user to the signin/signup page

	def destroy
    sign_out
    redirect_to root_url
  end
end
