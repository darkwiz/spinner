class BlocksController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	after_filter :is_follower, only: [:create]

	def create
		@user = User.find(params[:user_id])
		current_user.block!(@user)
		redirect_to @user 
	
	end


	def destroy
		@user = User.find(params[:user_id])
		current_user.remove_block!(@user)
		redirect_to @user
	end

private

	def is_follower
	     rel = current_user.reverse_relationships.find_by_follower_id(@user.id) 
	        unless rel.nil?
	        	rel.destroy
	        end
	end
end
