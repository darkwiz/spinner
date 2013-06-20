class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following , :followers]
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
      @users = User.page(params[:page])
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

  # Shows an user profile (and his own spins)

  def show
  	@user = User.find(params[:id])
    @spins = @user.spins.page(params[:page]).per(6)
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
    user = User.find(params[:id])
    unless user.admin?
      user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url
      else
      redirect_to users_url , :notice => "Cannot Delete Admin!"
      end
  end


  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private


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
