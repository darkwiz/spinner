class RelationshipsController < ApplicationController
 before_filter :signed_in_user

 def create
 	@user = User.find(params[:relationship][:followed_id])
 	current_user.follow!(@user)
 if @user.private
 	flash.now[:success] = 'Request sent!'
 	respond_to do |format|
 		format.html {redirect_to @user}
 		format.js 
 	end
 else
 	respond_to do |format|
 		format.html {redirect_to @user}
 		format.js
 	end
 end
 end

 def destroy
 	if Relationship.find(params[:id]).approved || params[:relationship][:from_follower]
 			@user = Relationship.find(params[:id]).followed
 			current_user.unfollow!(@user)
 		else
 			@user = Relationship.find(params[:id]).follower
 			current_user.reject!(@user)
 		end
 		respond_to do |format|
 		format.html {redirect_to @user}
 		format.js
 	end
 end

 def update
 		Relationship.find(params[:id]).update_attributes(:approved => true)
 		respond_to do |format|
 		format.html {redirect_to current_user}
 		format.js
 	end
 end

end
