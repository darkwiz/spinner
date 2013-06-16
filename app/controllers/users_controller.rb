class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: :destroy


  # If the user is already logged in this method performs the redirect to the current user page 
  # otherwise it provides both signin and signup forms (new.html.erb)

  def new
    if signed_in?
      redirect_to current_user
    else
     @user = User.new
   end
 end

  # Shows and paginates the Users list, thanks to the Kaminari gem that provide two helpful
  # methods page() and per(number_of_occurences in a page)

  def index
      @users = User.page(params[:page]).per(3) 
      #@users = User.all
  end

  # If the user is already logged in, and if is the correct user this method gives the user the ability
  # to edit his profile and settings


  def edit
    @user = User.find(params[:id])
  end

  # This method update the changes to the user profile or renders the edit form if any error occours

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  # Shows the user profile 

  def show
  	@user = User.find(params[:id])
  end

   # Creates and saves a new User, if any error occurs redirects the user to the signin/signup page

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  # Delete a User from the application(method reserved to the admin user)

  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
  end

  private


 # Method that checks whether the user is authenticated, if not authenticated stores the requested URL(to redirect the user once logged in)
 # and performs the redirect to the login page showing a warning message.


  def signed_in_user #:doc:
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  end


 # Method that checks whether the user is the correct one (i.e.: editing his just his own profile and not other profiles)
 # if he's not the user will be redirected to the root_path


  def correct_user #:doc:
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end


 # Checks what kind of user is attempting to destroy another user
 # and allows this action if the user is the admin, otherwise redirects the user to the root_url


  def admin_user #:doc:
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
