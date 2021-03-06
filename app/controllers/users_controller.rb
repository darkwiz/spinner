class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following , :followers]
  before_filter :correct_user,   only: [:edit, :update]


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
    if params[:search]
         @users = User.search(params[:search]).page(params[:page])
      else
         @users = User.page(params[:page])
      end
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
      sign_in_user @user
      redirect_to [:edit, @user]
    else
      render 'edit'
    end
  end

  # Shows an user profile (and his own spins)

  # @spins = @user.spins + Spin.including_respins(current_user)
  # @spins = Kaminari.paginate_array(@spins).page(params[:page])

  def show
    @spin = current_user.spins.build if signed_in?
  	@user = User.find(params[:id])
    ary = @user.personal_spins.sort_by(&:last_respin_time).reverse 
    @spins = Kaminari.paginate_array(ary).page(params[:page])
    @multispins = @user.user_multimedia
  end


   # Creates and saves a new User, if any error occurs redirects the user to the signin/signup page

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to new_user_confirmation_path(:email => params[:user][:email])
    else
      render 'new'
    end
  end
  

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.approved_relationships.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.approved_relationships.page(params[:page])
    render 'show_follow'
  end

  def pending_requests
    @user = User.find(params[:id])
    if current_user.private && current_user?(@user)
      @title = "Pending Following Requests"
      @users = @user.followers.pending_requests.page(params[:page])
      render 'show_follow'
    else
      render 'show'
    end
  end

  private

 # Method that checks whether the user is the correct one (i.e.: editing his just his own profile and not other profiles)
 # if he's not the user will be redirected to the root_path


  def correct_user #:doc:
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end


end
