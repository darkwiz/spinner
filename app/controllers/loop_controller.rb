class LoopController < ApplicationController
  def home
  	 if signed_in?
  	 	@spin = current_user.spins.build 
        @timeline_items = current_user.timeline.page(params[:page])
        #@debug = User.first
    else
        @user = User.new
   end
  end
end
