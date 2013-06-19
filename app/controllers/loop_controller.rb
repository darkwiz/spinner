class LoopController < ApplicationController
  def home
  	 if signed_in?
  	 	@spin = current_user.spins.build 
        @timeline_items = current_user.timeline.page(params[:page])
    else
        @user = User.new
   end
  end
end
