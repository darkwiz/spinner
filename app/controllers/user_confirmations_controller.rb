class UserConfirmationsController < ApplicationController
  def new
    user = User.find_by_email(params[:email]) # email empty
    user.send_confirm_email if user
    redirect_to root_url, :notice => "Email sent with activation instructions."
  end

  def show
  	@user = User.find_by_user_confirm_token!(params[:id])
  if @user.user_confirm_sent_at < 2.hours.ago
     redirect_to root_path, :alert => "Confirmation token is no longer valid."
  else @user.update_attributes(:confirmed_user => true)
     sign_in @user
     redirect_to root_url, :notice => "Succesfully registrated and activated!"
  end
  end
end
