class RespinsController < ApplicationController
	def create
		@spin = Spin.find(params[:respin][:spin_id])
		@spin.respin!(current_user)
		respond_to do |format|
 		  format.html {redirect_to current_user}
 		  format.js
 	    end
	end

	def destroy
		@user = Respin.find(params[:id]).respinner
		@spin = Respin.find(params[:id]).spin
		@spin.cancel_respin!(@user)
		respond_to do |format|
 		  format.html {redirect_to current_user}
 		  format.js
 	    end
	end
end